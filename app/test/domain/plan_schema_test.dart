import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/domain/plan_schema.dart';

void main() {
  group('looksLikePlanJson', () {
    test('returns true for pure JSON block', () {
      expect(looksLikePlanJson('{"weeks":12}'), isTrue);
    });
    test('returns true for JSON with leading/trailing whitespace', () {
      expect(looksLikePlanJson('  \n  {"weeks":12}\n  '), isTrue);
    });
    test('returns false for chat text', () {
      expect(looksLikePlanJson('好的，我已经为你准备好计划'), isFalse);
    });
  });

  group('validatePlanJson', () {
    test('accepts a complete valid plan', () {
      final raw = '''
      {
        "weeks": 12,
        "weekly_structure": "4 天训练 + 3 天休息",
        "goal_summary": "增肌",
        "training_days": [],
        "daily_meals": [],
        "startDate": "2026-08-14T00:00:00.000Z"
      }
      ''';
      final result = validatePlanJson(raw);
      expect(result.error, isNull);
      expect(result.plan, isNotNull);
      expect(result.plan!.weeks, 12);
    });

    test('rejects plan missing weeks field', () {
      final raw = '{"weekly_structure":"x","goal_summary":"y","training_days":[],"daily_meals":[],"startDate":"2026-08-14T00:00:00.000Z"}';
      final result = validatePlanJson(raw);
      expect(result.plan, isNull);
      expect(result.error, contains('weeks'));
    });

    test('rejects malformed JSON', () {
      final result = validatePlanJson('{not json}');
      expect(result.plan, isNull);
      expect(result.error, isNotNull);
    });
  });
}