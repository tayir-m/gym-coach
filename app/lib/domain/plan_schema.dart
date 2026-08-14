import 'dart:convert';

import 'models/plan.dart' show Plan;

class PlanValidationResult {
  final Plan? plan;
  final String? error;
  const PlanValidationResult.success(this.plan) : error = null;
  const PlanValidationResult.failure(this.error) : plan = null;
}

bool looksLikePlanJson(String text) {
  final trimmed = text.trim();
  if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return false;
  try {
    jsonDecode(trimmed);
    return true;
  } catch (_) {
    return false;
  }
}

PlanValidationResult validatePlanJson(String rawJson) {
  final trimmed = rawJson.trim();
  Map<String, dynamic>? json;
  try {
    final decoded = jsonDecode(trimmed);
    if (decoded is! Map<String, dynamic>) {
      return const PlanValidationResult.failure('JSON 顶层必须是对象');
    }
    json = decoded;
  } catch (e) {
    return PlanValidationResult.failure('JSON 解析失败: $e');
  }

  final required = ['weeks', 'weekly_structure', 'goal_summary', 'training_days', 'daily_meals'];
  for (final key in required) {
    if (!json.containsKey(key)) {
      return PlanValidationResult.failure('缺少必需字段: $key');
    }
  }

  if (json['weeks'] is! int || (json['weeks'] as int) <= 0) {
    return const PlanValidationResult.failure('weeks 必须是正整数');
  }
  if (json['training_days'] is! List) {
    return const PlanValidationResult.failure('training_days 必须是数组');
  }
  if (json['daily_meals'] is! List) {
    return const PlanValidationResult.failure('daily_meals 必须是数组');
  }

  try {
    final startDate = json['startDate'] is String
        ? DateTime.parse(json['startDate'] as String)
        : DateTime.now();
    final planWithDate = {...json, 'startDate': startDate.toIso8601String()};
    final plan = Plan.fromJson(planWithDate);
    return PlanValidationResult.success(plan);
  } catch (e) {
    return PlanValidationResult.failure('Plan 字段类型不匹配: $e');
  }
}