import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/user_profile.dart';

class ProfileRepository {
  final AppDatabase db;
  ProfileRepository(this.db);

  Future<UserProfile?> get() async {
    final row = await (db.select(db.userProfiles)..limit(1)).getSingleOrNull();
    if (row == null) return null;
    return UserProfile(
      age: row.age,
      heightCm: row.heightCm,
      weightKg: row.weightKg,
      sex: Sex.values.byName(row.sex),
      goal: Goal.values.byName(row.goal),
      experience: Experience.values.byName(row.experience),
      equipment: (jsonDecode(row.equipment) as List).cast<String>(),
      injuries: row.injuries,
      dietaryNotes: row.dietaryNotes,
      dailySchedule:
          (jsonDecode(row.dailySchedule) as Map).cast<String, bool>(),
      updatedAt: row.updatedAt,
    );
  }

  Future<void> save(UserProfile p) async {
    await db.into(db.userProfiles).insert(
      UserProfilesCompanion.insert(
        age: p.age,
        heightCm: p.heightCm,
        weightKg: p.weightKg,
        sex: p.sex.name,
        goal: p.goal.name,
        experience: p.experience.name,
        equipment: jsonEncode(p.equipment),
        injuries: Value(p.injuries),
        dietaryNotes: Value(p.dietaryNotes),
        dailySchedule: jsonEncode(p.dailySchedule),
        updatedAt: p.updatedAt,
      ),
    );
  }
}