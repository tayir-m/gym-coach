import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  UserProfiles,
  Plans,
  DayTasks,
  ChatMessages,
  Streaks,
  GamificationEvents,
  Badges,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
  );
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gym_coach.sqlite'));
    return driftDatabase(name: 'gym_coach', native: DriftNativeOptions(databasePath: () async => file.path));
  });
}
