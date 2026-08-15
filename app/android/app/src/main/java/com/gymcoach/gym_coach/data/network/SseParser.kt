package com.gymcoach.gym_coach.data.network

import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.jsonPrimitive

/**
 * Parses raw SSE `data:` lines and emits deltas.
 *
 * Per the SSE spec, multi-line `data:` fields are concatenated with `\n`. In
 * practice some LLM providers also emit back-to-back `data:` lines (the final
 * delta + `data: [DONE]`) without the blank-line separator that should close
 * an event — OkHttp will deliver both lines as a single `data` argument
 * joined by `\n`. This parser splits on newlines and treats each line as its
 * own logical event so both layouts work.
 *
 * Mirrors `lib/data/llm/sse_parser.dart`. Input lines may be either:
 *  - raw SSE form (`data: {"delta":"x"}`), or
 *  - already-stripped payload (`{"delta":"x"}`).
 *
 * Both are accepted so callers don't have to care whether OkHttp preprocessed
 * the stream.
 */
object SseParser {

    private val json = Json { ignoreUnknownKeys = true }

    /**
     * Inspect one SSE event payload. Returns:
     *  - [Outcome.Done] when a [DONE] sentinel line was seen (caller should
     *    close the EventSource);
     *  - [Outcome.Delta] when at least one line decoded as a delta JSON;
     *  - [Outcome.Ignore] when no actionable line was found.
     *
     * `onDelta` is invoked once per decoded delta, in order.
     */
    fun process(
        data: String,
        onDelta: (String) -> Unit
    ): Outcome {
        var any = false
        for (rawLine in data.split('\n')) {
            val payload = stripDataPrefix(rawLine.trim())
            if (payload.isEmpty()) continue
            if (payload == "[DONE]") return Outcome.Done
            val delta = extractDelta(payload)
            if (delta != null) {
                onDelta(delta)
                any = true
            }
        }
        return if (any) Outcome.Delta else Outcome.Ignore
    }

    /** Strip a leading `data:` (with optional single space) per SSE spec. */
    private fun stripDataPrefix(line: String): String =
        if (line.startsWith("data:")) line.removePrefix("data:").trimStart()
        else line

    private fun extractDelta(payload: String): String? = runCatching {
        val obj = json.parseToJsonElement(payload) as? JsonObject
            ?: return@runCatching null
        obj["delta"]?.jsonPrimitive?.contentOrNull
    }.getOrNull()

    sealed class Outcome {
        /** A [DONE] sentinel was seen. Caller must close the EventSource. */
        data object Done : Outcome()
        /** At least one delta was emitted. */
        data object Delta : Outcome()
        /** No actionable line (comment, retry, ping with no data, etc.). */
        data object Ignore : Outcome()
    }
}