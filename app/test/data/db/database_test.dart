import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/db/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('creates all tables on schema initialization', () async {
    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type='table'")
        .map((row) => row.read<String>('name'))
        .get();
    expect(tables, contains('user_profiles'));
    expect(tables, contains('plans'));
    expect(tables, contains('day_tasks'));
    expect(tables, contains('chat_messages'));
    expect(tables, contains('streaks'));
    expect(tables, contains('gamification_events'));
    expect(tables, contains('badges'));
  });

  test('inserts and reads a user profile', () async {
    await db.into(db.userProfiles).insert(
      UserProfilesCompanion.insert(
        age: 30,
        heightCm: 175,
        weightKg: 70,
        sex: 'male',
        goal: 'muscle_gain',
        experience: 'intermediate',
        equipment: '["dumbbells","gym"]',
        injuries: const Value.absent(),
        dietaryNotes: const Value('vegetarian'),
        dailySchedule: '{"morning":true,"evening":true}',
        updatedAt: DateTime.now(),
      ),
    );
    final all = await db.select(db.userProfiles).get();
    expect(all, hasLength(1));
    expect(all.first.goal, 'muscle_gain');
  });
}
