package com.gymcoach.gym_coach.data.network

import com.gymcoach.gym_coach.config.AppConfig
import com.gymcoach.gym_coach.data.network.dto.ChatDeltaDto
import com.gymcoach.gym_coach.data.network.dto.ChatRequestDto
import com.gymcoach.gym_coach.data.network.dto.MessageDto
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.channelFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.flow
import kotlinx.serialization.json.Json
import okhttp3.HttpUrl.Companion.toHttpUrl
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import okhttp3.sse.EventSource
import okhttp3.sse.EventSourceListener
import okhttp3.sse.EventSources
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Streams an LLM response as a Flow of `delta` strings.
 *
 * Retry policy mirrors the Flutter `llm_client.dart`:
 *   - 5xx -> retry up to MAX_RETRIES (3), backoff 200/400/800ms.
 *   - 4xx -> throw immediately (fatal).
 *   - Other throwables (e.g. socket error) -> retry.
 */
interface LlmClient {
    fun chat(
        messages: List<MessageDto>,
        model: String? = null,
        temperature: Double = 0.7
    ): Flow<String>
}

@Singleton
class LlmClientImpl @Inject constructor(
    private val httpClient: OkHttpClient,
    private val config: AppConfig
) : LlmClient {

    private val factory = EventSources.createFactory(httpClient)
    private val json = Json { ignoreUnknownKeys = true }
    private val jsonMedia = "application/json".toMediaType()

    override fun chat(
        messages: List<MessageDto>,
        model: String?,
        temperature: Double
    ): Flow<String> = flow {
        val url = (config.proxyEndpoint.trimEnd('/') + "/v1/chat").toHttpUrl()
        val body = json.encodeToString(
            ChatRequestDto.serializer(),
            ChatRequestDto(messages = messages, temperature = temperature, model = model)
        )

        var attempt = 0
        while (true) {
            try {
                openOneAsFlow(url, body).collect { emit(it) }
                return@flow
            } catch (e: CancellationException) {
                throw e
            } catch (e: FatalHttpException) {
                throw e
            } catch (e: Throwable) {
                if (attempt >= MAX_RETRIES - 1) throw e
                attempt += 1
                delay(RETRY_BASE_MS shl (attempt - 1))
            }
        }
    }

    /**
     * Opens a single EventSource, collects each delta into a List, and returns
     * it. Throws on retryable/fatal failures. Empty list on clean close with
     * no deltas (rare — usually there'd be at least one).
     */
    private fun openOneAsFlow(url: okhttp3.HttpUrl, body: String): Flow<String> = channelFlow {
        val req = Request.Builder().url(url).post(body.toRequestBody(jsonMedia)).build()
        val listener = object : EventSourceListener() {
            override fun onEvent(es: EventSource, id: String?, type: String?, data: String) {
                when (SseParser.process(data) { delta -> trySend(delta) }) {
                    SseParser.Outcome.Done -> { es.cancel(); close() }
                    else -> Unit
                }
            }

            override fun onFailure(es: EventSource, t: Throwable?, response: Response?) {
                val code = response?.code ?: -1
                response?.close()
                val outcome: Throwable = when {
                    t is CancellationException -> FatalHttpException("cancelled")
                    code in 400..499 -> FatalHttpException("HTTP $code")
                    code in 500..599 -> RetryableHttpException("HTTP $code")
                    t != null -> RetryableHttpException(t)
                    else -> FatalHttpException("closed")
                }
                es.cancel()
                close(outcome)
            }

            override fun onClosed(es: EventSource) { close() }
        }
        val es = factory.newEventSource(req, listener)
        awaitClose { es.cancel() }
    }

    companion object {
        const val MAX_RETRIES = 3
        const val RETRY_BASE_MS = 200L
    }
}

internal class RetryableHttpException(msgOrCause: Any) : RuntimeException(msgOrCause.toString())
internal class FatalHttpException(reason: String) : RuntimeException(reason)