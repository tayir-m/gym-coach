import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/day_task_repository.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/domain/models/day_task.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class PathScreen extends StatefulWidget {
  final PlanRepository planRepo;
  final DayTaskRepository taskRepo;
  const PathScreen({super.key, required this.planRepo, required this.taskRepo});

  @override
  State<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      appBar: AppBar(title: const Text('我的路径'), backgroundColor: AppColors.duoPurple),
      body: FutureBuilder(
        future: _loadTasks(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snap.data ?? <DayTask>[];
          final today = DateTime.now();
          final normToday = DateTime(today.year, today.month, today.day);
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (_, i) {
              final t = tasks[i];
              final normDate = DateTime(t.date.year, t.date.month, t.date.day);
              final isToday = normDate == normToday;
              final isPast = normDate.isBefore(normToday);
              final isMilestone = (i + 1) % 28 == 0;
              final color = isToday
                  ? AppColors.duoGold
                  : (t.completedWorkout ? AppColors.duoGreen : (isPast ? AppColors.duoGray : AppColors.duoGray));
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.duoBlack, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: isMilestone
                          ? const Icon(Icons.emoji_events, size: 16)
                          : Text('${i + 1}', style: const TextStyle(fontSize: 10)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.workout?.title ?? '休息日',
                        style: TextStyle(
                          fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isToday) const AppMascot(size: 32, mood: 'cheer'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<DayTask>> _loadTasks() async {
    final plan = await widget.planRepo.getActive();
    if (plan == null) return <DayTask>[];
    return widget.taskRepo.getAllForPlan(plan.id);
  }
}
