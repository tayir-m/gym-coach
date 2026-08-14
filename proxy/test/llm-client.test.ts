import { describe, it, expect, vi, beforeEach } from 'vitest';
import { QwenClient } from '../src/llm-client';

describe('QwenClient.streamChat', () => {
  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('streams chunks and parses SSE data lines', async () => {
    const sseBody = [
      'data: {"choices":[{"delta":{"content":"你"}}]}\n',
      'data: {"choices":[{"delta":{"content":"好"}}]}\n',
      'data: [DONE]\n',
    ].join('');

    const mockFetch = vi.fn().mockResolvedValue(
      new Response(sseBody, { status: 200, headers: { 'content-type': 'text/event-stream' } }),
    );
    vi.stubGlobal('fetch', mockFetch);

    const client = new QwenClient('test-key', 'qwen-plus', 'https://example.com/v1/chat/completions');
    const chunks: string[] = [];
    for await (const chunk of client.streamChat({
      messages: [{ role: 'user', content: 'hi' }],
      temperature: 0.7,
    })) {
      chunks.push(chunk);
    }
    expect(chunks).toEqual(['你', '好']);
  });

  it('throws on non-200 response', async () => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(new Response('bad', { status: 500 })));
    const client = new QwenClient('k', 'm', 'https://e');
    await expect(async () => {
      for await (const _ of client.streamChat({ messages: [], temperature: 0 })) { /* noop */ }
    }).rejects.toThrow();
  });
});
