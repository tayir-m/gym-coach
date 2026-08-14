import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/day_task_repository.dart';
import 'package:gym_coach/data/repositories/gamification_repository.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/features/today/today_controller.dart';
import 'package:gym_coach/theme/buttons.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class TodayScreen extends StatefulWidget {
  final PlanRepository planRepo;
  final DayTaskRepository taskRepo;
  final GamificationRepository gamifRepo;
  const TodayScreen({
    super.key,
    required this.planRepo,
    required this.taskRepo,
    required this.gamifRepo,
  });

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late final TodayController _ctrl = TodayController(
    planRepo: widget.planRepo,
    taskRepo: widget.taskRepo,
    gamifRepo: widget.gamifRepo,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      appBar: AppBar(title: const Text('今日任务'), backgroundColor: AppColors.duoGreen),
      body: FutureBuilder(
        future: _ctrl.load(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final task = snap.data;
          if (task == null) {
            return const Center(child: Text('今天没有任务，去跟教练聊聊'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const AppMascot(mood: 'cheer'),
                const SizedBox(height: 16),
                if (task.workout != null)
                  Card(
                    child: ListTile(
                      title: Text(task.workout!.title),
                      subtitle: Text('${task.workout!.estimatedMinutes} 分钟 · ${task.workout!.exercises.length} 个动作'),
                      trailing: task.completedWorkout
                          ? const Icon(Icons.check_circle, color: AppColors.duoGreen)
                          : AppButton(
                              label: '完成',
                              onPressed: () async {
                                final xp = await _ctrl.completeWorkout(task);
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('+$xp XP')),
                                  );
                                }
                              },
                            ),
                    ),
                  ),
                ...task.meals.map((m) => Card(
                      child: ListTile(
                        title: Text('${m.slot} · ${m.name}'),
                        subtitle: Text('${m.kcal} kcal'),
                        trailing: task.completedMeals[m.slot] == true
                            ? const Icon(Icons.check_circle, color: AppColors.duoGreen)
                            : AppButton(
                                label: '吃了',
                                onPressed: () async {
                                  final xp = await _ctrl.completeMeal(task, m.slot);
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('+$xp XP')),
                                    );
                                  }
                                },
                              ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
