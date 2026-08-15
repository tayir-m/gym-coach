import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/db/database.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/domain/models/plan.dart';

void main() {
  late AppDatabase db;
  late PlanRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = PlanRepository(db);
  });
  tearDown(() async => await db.close());

  test('create increments version and returns id', () async {
    final plan = Plan(
      weeks: 12,
      weeklyStructure: '4+3',
      goalSummary: 'test',
      trainingDays: const [],
      dailyMeals: const [],
      startDate: DateTime(2026, 8, 14),
    );
    await repo.create(plan);
    final id2 = await repo.create(plan);
    final active = await repo.getActive();
    expect(active, isNotNull);
    expect(active!.id, id2);
  });

  test('deactivateAll marks previous plans inactive', () async {
    final plan = Plan(
      weeks: 12,
      weeklyStructure: 'x',
      goalSummary: 'y',
      trainingDays: const [],
      dailyMeals: const [],
      startDate: DateTime(2026, 8, 14),
    );
    await repo.create(plan);
    await repo.deactivateAll();
    expect(await repo.getActive(), isNull);
  });
}