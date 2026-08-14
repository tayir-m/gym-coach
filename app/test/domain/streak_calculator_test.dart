import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/domain/streak_calculator.dart';

void main() {
  group('evaluateStreakOnActive', () {
    test('first ever active day sets streak to 1', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 0,
        longestStreakDays: 0,
        freezesRemaining: 2,
        lastActiveDate: null,
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 1);
      expect(r.streakBroken, isFalse);
      expect(r.freezesConsumed, 0);
    });

    test('consecutive day increments streak', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 2,
        lastActiveDate: DateTime(2026, 8, 13),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 6);
      expect(r.streakBroken, isFalse);
    });

    test('missed 1 day consumes freeze and preserves streak', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 2,
        lastActiveDate: DateTime(2026, 8, 12),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 6);
      expect(r.freezesConsumed, 1);
      expect(r.streakBroken, isFalse);
    });

    test('missed 2 days with no freezes resets streak', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 0,
        lastActiveDate: DateTime(2026, 8, 11),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 1);
      expect(r.streakBroken, isTrue);
      expect(r.newLongestDays, 10); // 不变
    });

    test('same-day active does nothing', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 2,
        lastActiveDate: DateTime(2026, 8, 14),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 5);
      expect(r.freezesConsumed, 0);
    });
  });

  group('shouldAwardFreeze', () {
    test('awards when 30 days passed since last award', () {
      final result = shouldAwardFreeze(
        lastFreezeAwardDate: DateTime(2026, 7, 15),
        now: DateTime(2026, 8, 14),
      );
      expect(result, isTrue);
    });

    test('does not award within 30 days', () {
      final result = shouldAwardFreeze(
        lastFreezeAwardDate: DateTime(2026, 8, 1),
        now: DateTime(2026, 8, 14),
      );
      expect(result, isFalse);
    });

    test('awards when never awarded and 30 days passed', () {
      final result = shouldAwardFreeze(
        lastFreezeAwardDate: null,
        now: DateTime(2026, 8, 14),
      );
      expect(result, isFalse); // 首次安装不立即给
    });
  });
}