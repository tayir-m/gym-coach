import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/db/database.dart';
import 'package:gym_coach/data/repositories/profile_repository.dart';
import 'package:gym_coach/domain/models/user_profile.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ProfileRepository(db);
  });
  tearDown(() async => await db.close());

  test('returns null when no profile saved', () async {
    expect(await repo.get(), isNull);
  });

  test('saves and reads profile', () async {
    final p = UserProfile(
      age: 28,
      heightCm: 175,
      weightKg: 72,
      sex: Sex.male,
      goal: Goal.muscleGain,
      experience: Experience.intermediate,
      equipment: const ['dumbbells', 'gym'],
      injuries: null,
      dietaryNotes: null,
      dailySchedule: const {'morning': true},
      updatedAt: DateTime(2026, 8, 14),
    );
    await repo.save(p);
    final loaded = await repo.get();
    expect(loaded?.age, 28);
    expect(loaded?.goal, Goal.muscleGain);
    expect(loaded?.equipment, ['dumbbells', 'gym']);
  });
}