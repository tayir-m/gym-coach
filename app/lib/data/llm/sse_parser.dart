import 'dart:async';
import 'dart:convert';

Stream<String> parseSse(Stream<List<int>> byteStream) async* {
  final lineStream = byteStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  String? dataBuffer;

  await for (final line in lineStream) {
    if (line.isEmpty) {
      // event boundary
      if (dataBuffer != null) {
        if (dataBuffer == '[DONE]') {
          return;
        }
        try {
          final json = jsonDecode(dataBuffer);
          if (json is Map && json['delta'] is String) {
            yield json['delta'] as String;
          }
        } catch (_) {/* skip */}
        dataBuffer = null;
      }
      continue;
    }
    if (line.startsWith(':')) continue;          // comment
    if (!line.startsWith('data:')) continue;     // other fields
    dataBuffer = (dataBuffer == null ? '' : '$dataBuffer\n') + line.substring(5).trim();
  }
}