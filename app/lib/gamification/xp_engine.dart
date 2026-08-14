class XpAward {
  final int xp;
  final String reason;
  const XpAward(this.xp, this.reason);
}

XpAward computeXpForWorkoutCompletion({required bool allMealsCompleted}) {
  if (allMealsCompleted) {
    return const XpAward(80, 'workout + all meals');
  }
  return const XpAward(30, 'workout');
}

XpAward computeXpForMealCompletion({
  required int mealsCompletedBefore,
  required int totalMeals,
}) {
  if (totalMeals > 0 && mealsCompletedBefore == totalMeals - 1) {
    return const XpAward(20, 'all meals');
  }
  return const XpAward(0, '');
}

XpAward computeXpForStreakMilestone({required int streakDays}) {
  const milestones = {7: 100, 30: 300, 100: 1000, 365: 5000};
  final xp = milestones[streakDays] ?? 0;
  return XpAward(xp, 'streak milestone');
}

XpAward computeXpForBadgeUnlock() => const XpAward(200, 'badge unlock');

XpAward computeXpForCoachAdjustment() => const XpAward(10, 'coach adjustment');

int levelFromXp(int totalXp) => (totalXp ~/ 1000) + 1;

int xpToNextLevel(int totalXp) {
  final level = levelFromXp(totalXp);
  return (level * 1000) - totalXp;
}