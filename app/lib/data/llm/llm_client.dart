import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'sse_parser.dart';

class LlmClient {
  final String endpoint;
  final String hmacSecret;
  final http.Client httpClient;
  final int maxRetries;

  LlmClient({
    required this.endpoint,
    required this.hmacSecret,
    http.Client? httpClient,
    this.maxRetries = 3,
  }) : httpClient = httpClient ?? http.Client();

  Stream<String> chat({
    required List<Map<String, String>> messages,
    String? model,
    double temperature = 0.7,
  }) async* {
    final body = jsonEncode({
      'messages': messages,
      'temperature': temperature,
      if (model != null) 'model': model,
    });

    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final signature = _sign(timestamp, body);

    var attempt = 0;
    while (true) {
      attempt++;
      try {
        final req = http.Request('POST', Uri.parse('$endpoint/v1/chat'))
          ..headers.addAll({
            'Content-Type': 'application/json',
            'X-Timestamp': timestamp,
            'X-Signature': signature,
          })
          ..body = body;
        final res = await httpClient.send(req);
        if (res.statusCode == 200) {
          yield* parseSse(res.stream);
          return;
        }
        if (attempt >= maxRetries || res.statusCode < 500) {
          throw Exception('LLM HTTP ${res.statusCode}');
        }
      } catch (_) {
        if (attempt >= maxRetries) rethrow;
      }
      await Future.delayed(Duration(milliseconds: 200 * (1 << (attempt - 1))));
    }
  }

  String _sign(String timestamp, String body) {
    final hmac = Hmac(sha256, utf8.encode(hmacSecret));
    final digest = hmac.convert(utf8.encode('$timestamp.$body'));
    return digest.toString();
  }

  void close() => httpClient.close();
}