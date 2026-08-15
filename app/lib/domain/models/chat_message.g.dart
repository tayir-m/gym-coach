// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  planId: (json['planId'] as num).toInt(),
  role: $enumDecode(_$ChatRoleEnumMap, json['role']),
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'role': _$ChatRoleEnumMap[instance.role]!,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ChatRoleEnumMap = {
  ChatRole.system: 'system',
  ChatRole.user: 'user',
  ChatRole.assistant: 'assistant',
};
