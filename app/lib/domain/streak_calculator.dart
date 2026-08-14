class StreakUpdate {
  final int newCurrentDays;
  final int newLongestDays;
  final int freezesConsumed;
  final bool streakBroken;
  const StreakUpdate({
    required this.newCurrentDays,
    required this.newLongestDays,
    required this.freezesConsumed,
    required this.streakBroken,
  });
}

StreakUpdate evaluateStreakOnActive({
  required int currentStreakDays,
  required int longestStreakDays,
  required int freezesRemaining,
  required DateTime? lastActiveDate,
  required DateTime now,
}) {
  if (lastActiveDate == null) {
    return StreakUpdate(
      newCurrentDays: 1,
      newLongestDays: longestStreakDays > 1 ? longestStreakDays : 1,
      freezesConsumed: 0,
      streakBroken: false,
    );
  }

  final daysSince = _daysBetween(lastActiveDate, now);

  if (daysSince == 0) {
    return StreakUpdate(
      newCurrentDays: currentStreakDays,
      newLongestDays: longestStreakDays,
      freezesConsumed: 0,
      streakBroken: false,
    );
  }

  if (daysSince == 1) {
    final newCurrent = currentStreakDays + 1;
    final newLongest = newCurrent > longestStreakDays ? newCurrent : longestStreakDays;
    return StreakUpdate(
      newCurrentDays: newCurrent,
      newLongestDays: newLongest,
      freezesConsumed: 0,
      streakBroken: false,
    );
  }

  // Missed >= 2 days
  final freezesToUse = daysSince - 1;
  if (freezesRemaining >= freezesToUse) {
    final newCurrent = currentStreakDays + 1;
    final newLongest = newCurrent > longestStreakDays ? newCurrent : longestStreakDays;
    return StreakUpdate(
      newCurrentDays: newCurrent,
      newLongestDays: newLongest,
      freezesConsumed: freezesToUse,
      streakBroken: false,
    );
  }

  // Not enough freezes
  final newCurrent = freezesRemaining + 1;
  return StreakUpdate(
    newCurrentDays: newCurrent,
    newLongestDays: longestStreakDays,
    freezesConsumed: freezesRemaining,
    streakBroken: true,
  );
}

bool shouldAwardFreeze({
  required DateTime? lastFreezeAwardDate,
  required DateTime now,
}) {
  if (lastFreezeAwardDate == null) return false;
  return _daysBetween(lastFreezeAwardDate, now) >= 30;
}

int _daysBetween(DateTime from, DateTime to) {
  final fromDay = DateTime(from.year, from.month, from.day);
  final toDay = DateTime(to.year, to.month, to.day);
  return toDay.difference(fromDay).inDays;
}