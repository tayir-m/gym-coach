import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_coach/config.dart';
import 'package:gym_coach/data/db/database.dart';
import 'package:gym_coach/data/llm/llm_client.dart';
import 'package:gym_coach/data/repositories/chat_repository.dart';
import 'package:gym_coach/data/repositories/day_task_repository.dart';
import 'package:gym_coach/data/repositories/gamification_repository.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/data/repositories/profile_repository.dart';
import 'package:gym_coach/router.dart';
import 'package:gym_coach/theme/colors.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final profileRepoProvider = Provider((ref) => ProfileRepository(ref.watch(databaseProvider)));
final planRepoProvider = Provider((ref) => PlanRepository(ref.watch(databaseProvider)));
final taskRepoProvider = Provider((ref) => DayTaskRepository(ref.watch(databaseProvider)));
final chatRepoProvider = Provider((ref) => ChatRepository(ref.watch(databaseProvider)));
final gamifRepoProvider = Provider((ref) => GamificationRepository(ref.watch(databaseProvider)));

final llmClientProvider = Provider<LlmClient>((ref) {
  final client = LlmClient(
    endpoint: AppConfig.proxyEndpoint,
    hmacSecret: AppConfig.hmacSecret,
  );
  ref.onDispose(client.close);
  return client;
});

class GymCoachApp extends ConsumerWidget {
  const GymCoachApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: '健身猫头鹰',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.duoGreen),
        useMaterial3: true,
      ),
      routerConfig: buildRouter(ref),
    );
  }
}
