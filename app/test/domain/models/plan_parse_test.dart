import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/domain/models/plan.dart';

void main() {
  test('Plan parses valid LLM JSON output', () {
    final json = {
      'weeks': 12,
      'weekly_structure': '4 天训练 + 3 天休息',
      'goal_summary': '12 周增肌',
      'training_days': [
        {
          'week': 1,
          'day_of_week': 1,
          'title': '上肢推',
          'focus': '增肌',
          'estimated_minutes': 45,
          'exercises': [
            {'name': '哑铃卧推', 'sets': 4, 'reps': '8-12', 'rest_seconds': 90},
          ],
        },
      ],
      'daily_meals': [
        {
          'week': 1,
          'day_of_week': 1,
          'total_kcal': 2200,
          'protein_g': 160,
          'carbs_g': 220,
          'fat_g': 70,
          'meals': [
            {
              'slot': 'breakfast',
              'name': '燕麦',
              'kcal': 480,
              'protein_g': 30,
              'carbs_g': 60,
              'fat_g': 12,
              'ingredients': ['燕麦 50g'],
            },
          ],
        },
      ],
      'startDate': '2026-08-14T00:00:00.000Z',
    };
    final plan = Plan.fromJson(json);
    expect(plan.weeks, 12);
    expect(plan.startDate, isA<DateTime>());
    expect(plan.trainingDays.first.exercises.first.name, '哑铃卧推');
    expect(plan.dailyMeals.first.meals.first.slot, 'breakfast');
  });
}
