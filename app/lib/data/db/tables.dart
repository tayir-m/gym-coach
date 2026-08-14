import 'package:drift/drift.dart';

@DataClassName('UserProfileRow')
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get age => integer()();
  RealColumn get heightCm => real()();
  RealColumn get weightKg => real()();
  TextColumn get sex => text()();
  TextColumn get goal => text()();
  TextColumn get experience => text()();
  TextColumn get equipment => text()();        // JSON array
  TextColumn get injuries => text().nullable()();
  TextColumn get dietaryNotes => text().nullable()();
  TextColumn get dailySchedule => text()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('PlanRow')
class Plans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get version => integer()();
  DateTimeColumn get startDate => dateTime()();
  IntColumn get weeks => integer()();
  TextColumn get planJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}

@DataClassName('DayTaskRow')
class DayTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId => integer().references(Plans, #id)();
  IntColumn get dayIndex => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get workoutJson => text()();
  TextColumn get mealsJson => text()();
  BoolColumn get completedWorkout => boolean().withDefault(const Constant(false))();
  TextColumn get completedMeals => text().withDefault(const Constant('{}'))();
  IntColumn get xpAwarded => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

@DataClassName('ChatMessageRow')
class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId => integer().references(Plans, #id)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
}

class Streaks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get currentDays => integer().withDefault(const Constant(0))();
  IntColumn get longestDays => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActiveDate => dateTime().nullable()();
  IntColumn get freezesRemaining => integer().withDefault(const Constant(2))();
}

class GamificationEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventType => text()();
  IntColumn get value => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

class Badges extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get icon => text()();
  TextColumn get conditionJson => text()();

  @override
  Set<Column> get primaryKey => {code};
}
