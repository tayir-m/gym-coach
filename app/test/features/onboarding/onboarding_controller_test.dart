import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/features/onboarding/onboarding_controller.dart';
import 'package:gym_coach/domain/plan_schema.dart';

void main() {
  test('tryExtractPlan returns Plan when text is valid JSON', () {
    final c = OnboardingController();
    final raw = '''
    {"weeks":12,"weekly_structure":"4+3","goal_summary":"增肌","training_days":[],"daily_meals":[]}
    ''';
    final plan = c.tryExtractPlan(raw);
    expect(plan, isNotNull);
    expect(plan!.weeks, 12);
  });

  test('tryExtractPlan returns null for plain text', () {
    final c = OnboardingController();
    expect(c.tryExtractPlan('好的，我问几个问题'), isNull);
  });

  test('looksLikePlanJson detects JSON shape', () {
    expect(looksLikePlanJson('{"weeks":1}'), isTrue);
    expect(looksLikePlanJson('hi'), isFalse);
  });
}