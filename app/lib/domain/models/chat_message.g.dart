// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real json_serializable-generated output.

part of 'chat_message.dart';

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with enum support.
  // Regenerate via build_runner on a dev box before use.
  return ChatMessage(
    planId: json['planId'] as int,
    role: $enumDecode(_$ChatRoleEnumMap, json['role']),
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) {
  // STUB: real implementation serializes with enum support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'planId': instance.planId,
    'role': _$ChatRoleEnumMap[instance.role]!,
    'content': instance.content,
    'createdAt': instance.createdAt.toIso8601String(),
  };
}

const _$ChatRoleEnumMap = {
  ChatRole.system: 'system',
  ChatRole.user: 'user',
  ChatRole.assistant: 'assistant',
};
