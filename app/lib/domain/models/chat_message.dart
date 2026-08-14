import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum ChatRole { system, user, assistant }

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int planId,
    required ChatRole role,
    required String content,
    required DateTime createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
