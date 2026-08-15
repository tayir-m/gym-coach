final _badgeConditions = <String, bool Function(Map<String, dynamic>)>{
  'FIRST_WORKOUT': (s) => (s['totalWorkoutsCompleted'] as int) >= 1,
  'ONE_WEEK_STREAK': (s) => (s['longestStreak'] as int) >= 7,
  'HUNDRED_DAYS': (s) => (s['longestStreak'] as int) >= 100,
  'IRON_STOMACH': (s) => (s['totalDaysAllMealsCompleted'] as int) >= 7,
  'FITNESS_OWL': (s) => (s['level'] as int) >= 10,
};

List<String> checkUnlockedBadges(Map<String, dynamic> stats) {
  return _badgeConditions.entries
      .where((e) => e.value(stats))
      .map((e) => e.key)
      .toList();
}