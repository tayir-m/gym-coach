import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/gamification/xp_engine.dart';

void main() {
  test('workout completion awards 30 xp', () {
    expect(computeXpForWorkoutCompletion(allMealsCompleted: false).xp, 30);
  });

  test('workout + all meals awards 80 xp (30+50)', () {
    expect(computeXpForWorkoutCompletion(allMealsCompleted: true).xp, 80);
  });

  test('all 4 meals completed awards 20 xp', () {
    expect(
      computeXpForMealCompletion(mealsCompletedBefore: 3, totalMeals: 4).xp,
      20,
    );
  });

  test('partial meals awards 0 xp', () {
    expect(
      computeXpForMealCompletion(mealsCompletedBefore: 2, totalMeals: 4).xp,
      0,
    );
  });

  test('streak milestones', () {
    expect(computeXpForStreakMilestone(streakDays: 7).xp, 100);
    expect(computeXpForStreakMilestone(streakDays: 30).xp, 300);
    expect(computeXpForStreakMilestone(streakDays: 100).xp, 1000);
    expect(computeXpForStreakMilestone(streakDays: 365).xp, 5000);
    expect(computeXpForStreakMilestone(streakDays: 10).xp, 0);
  });

  test('badge unlock awards 200', () {
    expect(computeXpForBadgeUnlock().xp, 200);
  });

  test('coach adjustment awards 10', () {
    expect(computeXpForCoachAdjustment().xp, 10);
  });

  test('level math', () {
    expect(levelFromXp(0), 1);
    expect(levelFromXp(999), 1);
    expect(levelFromXp(1000), 2);
    expect(levelFromXp(2500), 3);
    expect(xpToNextLevel(0), 1000);
    expect(xpToNextLevel(1500), 500);
  });
}