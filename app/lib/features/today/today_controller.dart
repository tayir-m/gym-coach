import '../../data/repositories/day_task_repository.dart';
import '../../data/repositories/gamification_repository.dart';
import '../../data/repositories/plan_repository.dart';
import '../../domain/models/day_task.dart';
import '../../gamification/xp_engine.dart';

class TodayController {
  final PlanRepository planRepo;
  final DayTaskRepository taskRepo;
  final GamificationRepository gamifRepo;
  TodayController({
    required this.planRepo,
    required this.taskRepo,
    required this.gamifRepo,
  });

  Future<DayTask?> load() async {
    final stored = await planRepo.getActive();
    if (stored == null) return null;
    final today = DateTime.now();
    final normalized = DateTime(today.year, today.month, today.day);
    return taskRepo.getByDate(stored.id, normalized);
  }

  Future<int> completeWorkout(DayTask task) async {
    if (task.dbId == null) {
      throw StateError('DayTask 必须从数据库读取后才能调用 completeWorkout');
    }
    if (task.completedWorkout) {
      throw StateError('Workout already completed');
    }
    final allMealsDone = task.meals.isNotEmpty &&
        task.meals.every((m) => task.completedMeals[m.slot] == true);
    final award = computeXpForWorkoutCompletion(allMealsCompleted: allMealsDone);
    await taskRepo.markWorkoutDone(task.dbId!);
    await taskRepo.awardXp(task.dbId!, award.xp);
    await gamifRepo.recordEvent('WORKOUT_DONE', award.xp);
    return award.xp;
  }

  Future<int> completeMeal(DayTask task, String slot) async {
    if (task.dbId == null) {
      throw StateError('DayTask 必须从数据库读取后才能调用 completeMeal');
    }
    if (task.completedMeals[slot] == true) {
      throw StateError('Meal slot $slot already completed');
    }
    final mealsCompleted = task.meals.where((m) => task.completedMeals[m.slot] == true || m.slot == slot).length;
    final award = computeXpForMealCompletion(
      mealsCompletedBefore: mealsCompleted - 1,
      totalMeals: task.meals.length,
    );
    await taskRepo.markMealDone(task.dbId!, slot, true);
    await taskRepo.awardXp(task.dbId!, award.xp);
    await gamifRepo.recordEvent('MEAL_DONE', award.xp);
    return award.xp;
  }
}