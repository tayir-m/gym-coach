import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/gamification/badge_engine.dart';

void main() {
  test('first workout unlocks FIRST_WORKOUT badge', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 1,
      'longestStreak': 0,
      'totalDaysAllMealsCompleted': 0,
      'level': 1,
    });
    expect(unlocked, contains('FIRST_WORKOUT'));
  });

  test('7 day streak unlocks ONE_WEEK_STREAK', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 7,
      'longestStreak': 7,
      'totalDaysAllMealsCompleted': 0,
      'level': 1,
    });
    expect(unlocked, contains('ONE_WEEK_STREAK'));
  });

  test('100 day streak unlocks HUNDRED_DAYS', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 100,
      'longestStreak': 100,
      'totalDaysAllMealsCompleted': 0,
      'level': 5,
    });
    expect(unlocked, contains('HUNDRED_DAYS'));
  });

  test('7 consecutive all-meal days unlocks IRON_STOMACH', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 7,
      'longestStreak': 7,
      'totalDaysAllMealsCompleted': 7,
      'level': 1,
    });
    expect(unlocked, contains('IRON_STOMACH'));
  });

  test('level 10 unlocks FITNESS_OWL', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 50,
      'longestStreak': 30,
      'totalDaysAllMealsCompleted': 0,
      'level': 10,
    });
    expect(unlocked, contains('FITNESS_OWL'));
  });

  test('no badges for new user', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 0,
      'longestStreak': 0,
      'totalDaysAllMealsCompleted': 0,
      'level': 1,
    });
    expect(unlocked, isEmpty);
  });
}