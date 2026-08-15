package com.gymcoach.gym_coach.data.network

import com.google.common.truth.Truth.assertThat
import org.junit.Test

/**
 * Unit-tests for [SseParser]. We exercise the parser directly on the exact
 * `data:` strings OkHttp's SSE machinery would hand to a listener — no
 * MockWebServer involved, since the real LlmClient integration test would
 * cover that end-to-end.
 *
 * The original Flutter `sse_parser_test.dart` had three scenarios. We keep the
 * same expectations:
 *  - a stream of `{"delta":"…"}` lines yields those deltas in order;
 *  - comments / event / id / retry lines with no `data:` are ignored;
 *  - a `[DONE]` sentinel terminates the stream and is NOT yielded as a delta.
 */
class SseParserTest {

    private val collected = mutableListOf<String>()
    private val parser = SseParser

    private fun feed(data: String): SseParser.Outcome =
        parser.process(data) { collected.add(it) }

    @Test
    fun `SSE response yields delta strings on data events`(): Unit {
        feed("""data: {"delta":"Hello "}""")
        feed("""data: {"delta":"world"}""")
        // Last event in the real protocol bundles the final delta + [DONE]
        // because no blank line separates them — the parser must split on \n.
        val outcome = feed("""data: {"delta":"!"}
data: [DONE]""")
        assertThat(outcome).isEqualTo(SseParser.Outcome.Done)
        assertThat(collected).containsExactly("Hello ", "world", "!").inOrder()
    }

    @Test
    fun `SSE parser ignores comment lines and non-data fields`(): Unit {
        val outcome = feed(""": this is a comment
event: ping
id: 42
retry: 1000

data: {"delta":"only delta"}""")
        assertThat(outcome).isEqualTo(SseParser.Outcome.Delta)
        assertThat(collected).containsExactly("only delta")
    }

    @Test
    fun `pure DONE sentinel returns Done without emitting a delta`(): Unit {
        val outcome = feed("data: [DONE]")
        assertThat(outcome).isEqualTo(SseParser.Outcome.Done)
        assertThat(collected).isEmpty()
    }

    @Test
    fun `blank data and unrecognized payloads are ignored`(): Unit {
        assertThat(feed("")).isEqualTo(SseParser.Outcome.Ignore)
        assertThat(feed("not json at all")).isEqualTo(SseParser.Outcome.Ignore)
        assertThat(feed("""data: {"no_delta":"x"}""")).isEqualTo(SseParser.Outcome.Ignore)
        assertThat(collected).isEmpty()
    }
}