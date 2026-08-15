// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _experienceMeta = const VerificationMeta(
    'experience',
  );
  @override
  late final GeneratedColumn<String> experience = GeneratedColumn<String>(
    'experience',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _injuriesMeta = const VerificationMeta(
    'injuries',
  );
  @override
  late final GeneratedColumn<String> injuries = GeneratedColumn<String>(
    'injuries',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dietaryNotesMeta = const VerificationMeta(
    'dietaryNotes',
  );
  @override
  late final GeneratedColumn<String> dietaryNotes = GeneratedColumn<String>(
    'dietary_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyScheduleMeta = const VerificationMeta(
    'dailySchedule',
  );
  @override
  late final GeneratedColumn<String> dailySchedule = GeneratedColumn<String>(
    'daily_schedule',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    age,
    heightCm,
    weightKg,
    sex,
    goal,
    experience,
    equipment,
    injuries,
    dietaryNotes,
    dailySchedule,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('experience')) {
      context.handle(
        _experienceMeta,
        experience.isAcceptableOrUnknown(data['experience']!, _experienceMeta),
      );
    } else if (isInserting) {
      context.missing(_experienceMeta);
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    } else if (isInserting) {
      context.missing(_equipmentMeta);
    }
    if (data.containsKey('injuries')) {
      context.handle(
        _injuriesMeta,
        injuries.isAcceptableOrUnknown(data['injuries']!, _injuriesMeta),
      );
    }
    if (data.containsKey('dietary_notes')) {
      context.handle(
        _dietaryNotesMeta,
        dietaryNotes.isAcceptableOrUnknown(
          data['dietary_notes']!,
          _dietaryNotesMeta,
        ),
      );
    }
    if (data.containsKey('daily_schedule')) {
      context.handle(
        _dailyScheduleMeta,
        dailySchedule.isAcceptableOrUnknown(
          data['daily_schedule']!,
          _dailyScheduleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyScheduleMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      experience: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}experience'],
      )!,
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      )!,
      injuries: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}injuries'],
      ),
      dietaryNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dietary_notes'],
      ),
      dailySchedule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_schedule'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final int id;
  final int age;
  final double heightCm;
  final double weightKg;
  final String sex;
  final String goal;
  final String experience;
  final String equipment;
  final String? injuries;
  final String? dietaryNotes;
  final String dailySchedule;
  final DateTime updatedAt;
  const UserProfileRow({
    required this.id,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.sex,
    required this.goal,
    required this.experience,
    required this.equipment,
    this.injuries,
    this.dietaryNotes,
    required this.dailySchedule,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['age'] = Variable<int>(age);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['sex'] = Variable<String>(sex);
    map['goal'] = Variable<String>(goal);
    map['experience'] = Variable<String>(experience);
    map['equipment'] = Variable<String>(equipment);
    if (!nullToAbsent || injuries != null) {
      map['injuries'] = Variable<String>(injuries);
    }
    if (!nullToAbsent || dietaryNotes != null) {
      map['dietary_notes'] = Variable<String>(dietaryNotes);
    }
    map['daily_schedule'] = Variable<String>(dailySchedule);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      age: Value(age),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      sex: Value(sex),
      goal: Value(goal),
      experience: Value(experience),
      equipment: Value(equipment),
      injuries: injuries == null && nullToAbsent
          ? const Value.absent()
          : Value(injuries),
      dietaryNotes: dietaryNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(dietaryNotes),
      dailySchedule: Value(dailySchedule),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      id: serializer.fromJson<int>(json['id']),
      age: serializer.fromJson<int>(json['age']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      sex: serializer.fromJson<String>(json['sex']),
      goal: serializer.fromJson<String>(json['goal']),
      experience: serializer.fromJson<String>(json['experience']),
      equipment: serializer.fromJson<String>(json['equipment']),
      injuries: serializer.fromJson<String?>(json['injuries']),
      dietaryNotes: serializer.fromJson<String?>(json['dietaryNotes']),
      dailySchedule: serializer.fromJson<String>(json['dailySchedule']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'age': serializer.toJson<int>(age),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'sex': serializer.toJson<String>(sex),
      'goal': serializer.toJson<String>(goal),
      'experience': serializer.toJson<String>(experience),
      'equipment': serializer.toJson<String>(equipment),
      'injuries': serializer.toJson<String?>(injuries),
      'dietaryNotes': serializer.toJson<String?>(dietaryNotes),
      'dailySchedule': serializer.toJson<String>(dailySchedule),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfileRow copyWith({
    int? id,
    int? age,
    double? heightCm,
    double? weightKg,
    String? sex,
    String? goal,
    String? experience,
    String? equipment,
    Value<String?> injuries = const Value.absent(),
    Value<String?> dietaryNotes = const Value.absent(),
    String? dailySchedule,
    DateTime? updatedAt,
  }) => UserProfileRow(
    id: id ?? this.id,
    age: age ?? this.age,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    sex: sex ?? this.sex,
    goal: goal ?? this.goal,
    experience: experience ?? this.experience,
    equipment: equipment ?? this.equipment,
    injuries: injuries.present ? injuries.value : this.injuries,
    dietaryNotes: dietaryNotes.present ? dietaryNotes.value : this.dietaryNotes,
    dailySchedule: dailySchedule ?? this.dailySchedule,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfileRow copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileRow(
      id: data.id.present ? data.id.value : this.id,
      age: data.age.present ? data.age.value : this.age,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      sex: data.sex.present ? data.sex.value : this.sex,
      goal: data.goal.present ? data.goal.value : this.goal,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      injuries: data.injuries.present ? data.injuries.value : this.injuries,
      dietaryNotes: data.dietaryNotes.present
          ? data.dietaryNotes.value
          : this.dietaryNotes,
      dailySchedule: data.dailySchedule.present
          ? data.dailySchedule.value
          : this.dailySchedule,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('sex: $sex, ')
          ..write('goal: $goal, ')
          ..write('experience: $experience, ')
          ..write('equipment: $equipment, ')
          ..write('injuries: $injuries, ')
          ..write('dietaryNotes: $dietaryNotes, ')
          ..write('dailySchedule: $dailySchedule, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    age,
    heightCm,
    weightKg,
    sex,
    goal,
    experience,
    equipment,
    injuries,
    dietaryNotes,
    dailySchedule,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.id == this.id &&
          other.age == this.age &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.sex == this.sex &&
          other.goal == this.goal &&
          other.experience == this.experience &&
          other.equipment == this.equipment &&
          other.injuries == this.injuries &&
          other.dietaryNotes == this.dietaryNotes &&
          other.dailySchedule == this.dailySchedule &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<int> id;
  final Value<int> age;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<String> sex;
  final Value<String> goal;
  final Value<String> experience;
  final Value<String> equipment;
  final Value<String?> injuries;
  final Value<String?> dietaryNotes;
  final Value<String> dailySchedule;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.age = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.sex = const Value.absent(),
    this.goal = const Value.absent(),
    this.experience = const Value.absent(),
    this.equipment = const Value.absent(),
    this.injuries = const Value.absent(),
    this.dietaryNotes = const Value.absent(),
    this.dailySchedule = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required int age,
    required double heightCm,
    required double weightKg,
    required String sex,
    required String goal,
    required String experience,
    required String equipment,
    this.injuries = const Value.absent(),
    this.dietaryNotes = const Value.absent(),
    required String dailySchedule,
    required DateTime updatedAt,
  }) : age = Value(age),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       sex = Value(sex),
       goal = Value(goal),
       experience = Value(experience),
       equipment = Value(equipment),
       dailySchedule = Value(dailySchedule),
       updatedAt = Value(updatedAt);
  static Insertable<UserProfileRow> custom({
    Expression<int>? id,
    Expression<int>? age,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? sex,
    Expression<String>? goal,
    Expression<String>? experience,
    Expression<String>? equipment,
    Expression<String>? injuries,
    Expression<String>? dietaryNotes,
    Expression<String>? dailySchedule,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (age != null) 'age': age,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (sex != null) 'sex': sex,
      if (goal != null) 'goal': goal,
      if (experience != null) 'experience': experience,
      if (equipment != null) 'equipment': equipment,
      if (injuries != null) 'injuries': injuries,
      if (dietaryNotes != null) 'dietary_notes': dietaryNotes,
      if (dailySchedule != null) 'daily_schedule': dailySchedule,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<int>? age,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<String>? sex,
    Value<String>? goal,
    Value<String>? experience,
    Value<String>? equipment,
    Value<String?>? injuries,
    Value<String?>? dietaryNotes,
    Value<String>? dailySchedule,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      sex: sex ?? this.sex,
      goal: goal ?? this.goal,
      experience: experience ?? this.experience,
      equipment: equipment ?? this.equipment,
      injuries: injuries ?? this.injuries,
      dietaryNotes: dietaryNotes ?? this.dietaryNotes,
      dailySchedule: dailySchedule ?? this.dailySchedule,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (experience.present) {
      map['experience'] = Variable<String>(experience.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (injuries.present) {
      map['injuries'] = Variable<String>(injuries.value);
    }
    if (dietaryNotes.present) {
      map['dietary_notes'] = Variable<String>(dietaryNotes.value);
    }
    if (dailySchedule.present) {
      map['daily_schedule'] = Variable<String>(dailySchedule.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('sex: $sex, ')
          ..write('goal: $goal, ')
          ..write('experience: $experience, ')
          ..write('equipment: $equipment, ')
          ..write('injuries: $injuries, ')
          ..write('dietaryNotes: $dietaryNotes, ')
          ..write('dailySchedule: $dailySchedule, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlansTable extends Plans with TableInfo<$PlansTable, PlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeksMeta = const VerificationMeta('weeks');
  @override
  late final GeneratedColumn<int> weeks = GeneratedColumn<int>(
    'weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planJsonMeta = const VerificationMeta(
    'planJson',
  );
  @override
  late final GeneratedColumn<String> planJson = GeneratedColumn<String>(
    'plan_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    version,
    startDate,
    weeks,
    planJson,
    createdAt,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('weeks')) {
      context.handle(
        _weeksMeta,
        weeks.isAcceptableOrUnknown(data['weeks']!, _weeksMeta),
      );
    } else if (isInserting) {
      context.missing(_weeksMeta);
    }
    if (data.containsKey('plan_json')) {
      context.handle(
        _planJsonMeta,
        planJson.isAcceptableOrUnknown(data['plan_json']!, _planJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_planJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      weeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weeks'],
      )!,
      planJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class PlanRow extends DataClass implements Insertable<PlanRow> {
  final int id;
  final int version;
  final DateTime startDate;
  final int weeks;
  final String planJson;
  final DateTime createdAt;
  final bool active;
  const PlanRow({
    required this.id,
    required this.version,
    required this.startDate,
    required this.weeks,
    required this.planJson,
    required this.createdAt,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['version'] = Variable<int>(version);
    map['start_date'] = Variable<DateTime>(startDate);
    map['weeks'] = Variable<int>(weeks);
    map['plan_json'] = Variable<String>(planJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['active'] = Variable<bool>(active);
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      version: Value(version),
      startDate: Value(startDate),
      weeks: Value(weeks),
      planJson: Value(planJson),
      createdAt: Value(createdAt),
      active: Value(active),
    );
  }

  factory PlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanRow(
      id: serializer.fromJson<int>(json['id']),
      version: serializer.fromJson<int>(json['version']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      weeks: serializer.fromJson<int>(json['weeks']),
      planJson: serializer.fromJson<String>(json['planJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'version': serializer.toJson<int>(version),
      'startDate': serializer.toJson<DateTime>(startDate),
      'weeks': serializer.toJson<int>(weeks),
      'planJson': serializer.toJson<String>(planJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'active': serializer.toJson<bool>(active),
    };
  }

  PlanRow copyWith({
    int? id,
    int? version,
    DateTime? startDate,
    int? weeks,
    String? planJson,
    DateTime? createdAt,
    bool? active,
  }) => PlanRow(
    id: id ?? this.id,
    version: version ?? this.version,
    startDate: startDate ?? this.startDate,
    weeks: weeks ?? this.weeks,
    planJson: planJson ?? this.planJson,
    createdAt: createdAt ?? this.createdAt,
    active: active ?? this.active,
  );
  PlanRow copyWithCompanion(PlansCompanion data) {
    return PlanRow(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      weeks: data.weeks.present ? data.weeks.value : this.weeks,
      planJson: data.planJson.present ? data.planJson.value : this.planJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanRow(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('planJson: $planJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, version, startDate, weeks, planJson, createdAt, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanRow &&
          other.id == this.id &&
          other.version == this.version &&
          other.startDate == this.startDate &&
          other.weeks == this.weeks &&
          other.planJson == this.planJson &&
          other.createdAt == this.createdAt &&
          other.active == this.active);
}

class PlansCompanion extends UpdateCompanion<PlanRow> {
  final Value<int> id;
  final Value<int> version;
  final Value<DateTime> startDate;
  final Value<int> weeks;
  final Value<String> planJson;
  final Value<DateTime> createdAt;
  final Value<bool> active;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
    this.startDate = const Value.absent(),
    this.weeks = const Value.absent(),
    this.planJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.active = const Value.absent(),
  });
  PlansCompanion.insert({
    this.id = const Value.absent(),
    required int version,
    required DateTime startDate,
    required int weeks,
    required String planJson,
    required DateTime createdAt,
    this.active = const Value.absent(),
  }) : version = Value(version),
       startDate = Value(startDate),
       weeks = Value(weeks),
       planJson = Value(planJson),
       createdAt = Value(createdAt);
  static Insertable<PlanRow> custom({
    Expression<int>? id,
    Expression<int>? version,
    Expression<DateTime>? startDate,
    Expression<int>? weeks,
    Expression<String>? planJson,
    Expression<DateTime>? createdAt,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
      if (startDate != null) 'start_date': startDate,
      if (weeks != null) 'weeks': weeks,
      if (planJson != null) 'plan_json': planJson,
      if (createdAt != null) 'created_at': createdAt,
      if (active != null) 'active': active,
    });
  }

  PlansCompanion copyWith({
    Value<int>? id,
    Value<int>? version,
    Value<DateTime>? startDate,
    Value<int>? weeks,
    Value<String>? planJson,
    Value<DateTime>? createdAt,
    Value<bool>? active,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
      startDate: startDate ?? this.startDate,
      weeks: weeks ?? this.weeks,
      planJson: planJson ?? this.planJson,
      createdAt: createdAt ?? this.createdAt,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (weeks.present) {
      map['weeks'] = Variable<int>(weeks.value);
    }
    if (planJson.present) {
      map['plan_json'] = Variable<String>(planJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('planJson: $planJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

class $DayTasksTable extends DayTasks
    with TableInfo<$DayTasksTable, DayTaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plans (id)',
    ),
  );
  static const VerificationMeta _dayIndexMeta = const VerificationMeta(
    'dayIndex',
  );
  @override
  late final GeneratedColumn<int> dayIndex = GeneratedColumn<int>(
    'day_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutJsonMeta = const VerificationMeta(
    'workoutJson',
  );
  @override
  late final GeneratedColumn<String> workoutJson = GeneratedColumn<String>(
    'workout_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealsJsonMeta = const VerificationMeta(
    'mealsJson',
  );
  @override
  late final GeneratedColumn<String> mealsJson = GeneratedColumn<String>(
    'meals_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedWorkoutMeta = const VerificationMeta(
    'completedWorkout',
  );
  @override
  late final GeneratedColumn<bool> completedWorkout = GeneratedColumn<bool>(
    'completed_workout',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed_workout" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedMealsMeta = const VerificationMeta(
    'completedMeals',
  );
  @override
  late final GeneratedColumn<String> completedMeals = GeneratedColumn<String>(
    'completed_meals',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _xpAwardedMeta = const VerificationMeta(
    'xpAwarded',
  );
  @override
  late final GeneratedColumn<int> xpAwarded = GeneratedColumn<int>(
    'xp_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    dayIndex,
    date,
    workoutJson,
    mealsJson,
    completedWorkout,
    completedMeals,
    xpAwarded,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayTaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('day_index')) {
      context.handle(
        _dayIndexMeta,
        dayIndex.isAcceptableOrUnknown(data['day_index']!, _dayIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_dayIndexMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('workout_json')) {
      context.handle(
        _workoutJsonMeta,
        workoutJson.isAcceptableOrUnknown(
          data['workout_json']!,
          _workoutJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutJsonMeta);
    }
    if (data.containsKey('meals_json')) {
      context.handle(
        _mealsJsonMeta,
        mealsJson.isAcceptableOrUnknown(data['meals_json']!, _mealsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_mealsJsonMeta);
    }
    if (data.containsKey('completed_workout')) {
      context.handle(
        _completedWorkoutMeta,
        completedWorkout.isAcceptableOrUnknown(
          data['completed_workout']!,
          _completedWorkoutMeta,
        ),
      );
    }
    if (data.containsKey('completed_meals')) {
      context.handle(
        _completedMealsMeta,
        completedMeals.isAcceptableOrUnknown(
          data['completed_meals']!,
          _completedMealsMeta,
        ),
      );
    }
    if (data.containsKey('xp_awarded')) {
      context.handle(
        _xpAwardedMeta,
        xpAwarded.isAcceptableOrUnknown(data['xp_awarded']!, _xpAwardedMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayTaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayTaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      dayIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_index'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      workoutJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_json'],
      )!,
      mealsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meals_json'],
      )!,
      completedWorkout: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed_workout'],
      )!,
      completedMeals: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_meals'],
      )!,
      xpAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_awarded'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $DayTasksTable createAlias(String alias) {
    return $DayTasksTable(attachedDatabase, alias);
  }
}

class DayTaskRow extends DataClass implements Insertable<DayTaskRow> {
  final int id;
  final int planId;
  final int dayIndex;
  final DateTime date;
  final String workoutJson;
  final String mealsJson;
  final bool completedWorkout;
  final String completedMeals;
  final int xpAwarded;
  final DateTime? completedAt;
  const DayTaskRow({
    required this.id,
    required this.planId,
    required this.dayIndex,
    required this.date,
    required this.workoutJson,
    required this.mealsJson,
    required this.completedWorkout,
    required this.completedMeals,
    required this.xpAwarded,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    map['day_index'] = Variable<int>(dayIndex);
    map['date'] = Variable<DateTime>(date);
    map['workout_json'] = Variable<String>(workoutJson);
    map['meals_json'] = Variable<String>(mealsJson);
    map['completed_workout'] = Variable<bool>(completedWorkout);
    map['completed_meals'] = Variable<String>(completedMeals);
    map['xp_awarded'] = Variable<int>(xpAwarded);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  DayTasksCompanion toCompanion(bool nullToAbsent) {
    return DayTasksCompanion(
      id: Value(id),
      planId: Value(planId),
      dayIndex: Value(dayIndex),
      date: Value(date),
      workoutJson: Value(workoutJson),
      mealsJson: Value(mealsJson),
      completedWorkout: Value(completedWorkout),
      completedMeals: Value(completedMeals),
      xpAwarded: Value(xpAwarded),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DayTaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayTaskRow(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      dayIndex: serializer.fromJson<int>(json['dayIndex']),
      date: serializer.fromJson<DateTime>(json['date']),
      workoutJson: serializer.fromJson<String>(json['workoutJson']),
      mealsJson: serializer.fromJson<String>(json['mealsJson']),
      completedWorkout: serializer.fromJson<bool>(json['completedWorkout']),
      completedMeals: serializer.fromJson<String>(json['completedMeals']),
      xpAwarded: serializer.fromJson<int>(json['xpAwarded']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'dayIndex': serializer.toJson<int>(dayIndex),
      'date': serializer.toJson<DateTime>(date),
      'workoutJson': serializer.toJson<String>(workoutJson),
      'mealsJson': serializer.toJson<String>(mealsJson),
      'completedWorkout': serializer.toJson<bool>(completedWorkout),
      'completedMeals': serializer.toJson<String>(completedMeals),
      'xpAwarded': serializer.toJson<int>(xpAwarded),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  DayTaskRow copyWith({
    int? id,
    int? planId,
    int? dayIndex,
    DateTime? date,
    String? workoutJson,
    String? mealsJson,
    bool? completedWorkout,
    String? completedMeals,
    int? xpAwarded,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => DayTaskRow(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    dayIndex: dayIndex ?? this.dayIndex,
    date: date ?? this.date,
    workoutJson: workoutJson ?? this.workoutJson,
    mealsJson: mealsJson ?? this.mealsJson,
    completedWorkout: completedWorkout ?? this.completedWorkout,
    completedMeals: completedMeals ?? this.completedMeals,
    xpAwarded: xpAwarded ?? this.xpAwarded,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  DayTaskRow copyWithCompanion(DayTasksCompanion data) {
    return DayTaskRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      dayIndex: data.dayIndex.present ? data.dayIndex.value : this.dayIndex,
      date: data.date.present ? data.date.value : this.date,
      workoutJson: data.workoutJson.present
          ? data.workoutJson.value
          : this.workoutJson,
      mealsJson: data.mealsJson.present ? data.mealsJson.value : this.mealsJson,
      completedWorkout: data.completedWorkout.present
          ? data.completedWorkout.value
          : this.completedWorkout,
      completedMeals: data.completedMeals.present
          ? data.completedMeals.value
          : this.completedMeals,
      xpAwarded: data.xpAwarded.present ? data.xpAwarded.value : this.xpAwarded,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayTaskRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayIndex: $dayIndex, ')
          ..write('date: $date, ')
          ..write('workoutJson: $workoutJson, ')
          ..write('mealsJson: $mealsJson, ')
          ..write('completedWorkout: $completedWorkout, ')
          ..write('completedMeals: $completedMeals, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    dayIndex,
    date,
    workoutJson,
    mealsJson,
    completedWorkout,
    completedMeals,
    xpAwarded,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayTaskRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.dayIndex == this.dayIndex &&
          other.date == this.date &&
          other.workoutJson == this.workoutJson &&
          other.mealsJson == this.mealsJson &&
          other.completedWorkout == this.completedWorkout &&
          other.completedMeals == this.completedMeals &&
          other.xpAwarded == this.xpAwarded &&
          other.completedAt == this.completedAt);
}

class DayTasksCompanion extends UpdateCompanion<DayTaskRow> {
  final Value<int> id;
  final Value<int> planId;
  final Value<int> dayIndex;
  final Value<DateTime> date;
  final Value<String> workoutJson;
  final Value<String> mealsJson;
  final Value<bool> completedWorkout;
  final Value<String> completedMeals;
  final Value<int> xpAwarded;
  final Value<DateTime?> completedAt;
  const DayTasksCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.dayIndex = const Value.absent(),
    this.date = const Value.absent(),
    this.workoutJson = const Value.absent(),
    this.mealsJson = const Value.absent(),
    this.completedWorkout = const Value.absent(),
    this.completedMeals = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  DayTasksCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    required int dayIndex,
    required DateTime date,
    required String workoutJson,
    required String mealsJson,
    this.completedWorkout = const Value.absent(),
    this.completedMeals = const Value.absent(),
    this.xpAwarded = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : planId = Value(planId),
       dayIndex = Value(dayIndex),
       date = Value(date),
       workoutJson = Value(workoutJson),
       mealsJson = Value(mealsJson);
  static Insertable<DayTaskRow> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? dayIndex,
    Expression<DateTime>? date,
    Expression<String>? workoutJson,
    Expression<String>? mealsJson,
    Expression<bool>? completedWorkout,
    Expression<String>? completedMeals,
    Expression<int>? xpAwarded,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (dayIndex != null) 'day_index': dayIndex,
      if (date != null) 'date': date,
      if (workoutJson != null) 'workout_json': workoutJson,
      if (mealsJson != null) 'meals_json': mealsJson,
      if (completedWorkout != null) 'completed_workout': completedWorkout,
      if (completedMeals != null) 'completed_meals': completedMeals,
      if (xpAwarded != null) 'xp_awarded': xpAwarded,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  DayTasksCompanion copyWith({
    Value<int>? id,
    Value<int>? planId,
    Value<int>? dayIndex,
    Value<DateTime>? date,
    Value<String>? workoutJson,
    Value<String>? mealsJson,
    Value<bool>? completedWorkout,
    Value<String>? completedMeals,
    Value<int>? xpAwarded,
    Value<DateTime?>? completedAt,
  }) {
    return DayTasksCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dayIndex: dayIndex ?? this.dayIndex,
      date: date ?? this.date,
      workoutJson: workoutJson ?? this.workoutJson,
      mealsJson: mealsJson ?? this.mealsJson,
      completedWorkout: completedWorkout ?? this.completedWorkout,
      completedMeals: completedMeals ?? this.completedMeals,
      xpAwarded: xpAwarded ?? this.xpAwarded,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (dayIndex.present) {
      map['day_index'] = Variable<int>(dayIndex.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (workoutJson.present) {
      map['workout_json'] = Variable<String>(workoutJson.value);
    }
    if (mealsJson.present) {
      map['meals_json'] = Variable<String>(mealsJson.value);
    }
    if (completedWorkout.present) {
      map['completed_workout'] = Variable<bool>(completedWorkout.value);
    }
    if (completedMeals.present) {
      map['completed_meals'] = Variable<String>(completedMeals.value);
    }
    if (xpAwarded.present) {
      map['xp_awarded'] = Variable<int>(xpAwarded.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayTasksCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayIndex: $dayIndex, ')
          ..write('date: $date, ')
          ..write('workoutJson: $workoutJson, ')
          ..write('mealsJson: $mealsJson, ')
          ..write('completedWorkout: $completedWorkout, ')
          ..write('completedMeals: $completedMeals, ')
          ..write('xpAwarded: $xpAwarded, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plans (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, planId, role, content, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessageRow extends DataClass implements Insertable<ChatMessageRow> {
  final int id;
  final int planId;
  final String role;
  final String content;
  final DateTime createdAt;
  const ChatMessageRow({
    required this.id,
    required this.planId,
    required this.role,
    required this.content,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      planId: Value(planId),
      role: Value(role),
      content: Value(content),
      createdAt: Value(createdAt),
    );
  }

  factory ChatMessageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageRow(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChatMessageRow copyWith({
    int? id,
    int? planId,
    String? role,
    String? content,
    DateTime? createdAt,
  }) => ChatMessageRow(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    role: role ?? this.role,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
  );
  ChatMessageRow copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessageRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, planId, role, content, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.role == this.role &&
          other.content == this.content &&
          other.createdAt == this.createdAt);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessageRow> {
  final Value<int> id;
  final Value<int> planId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> createdAt;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    required String role,
    required String content,
    required DateTime createdAt,
  }) : planId = Value(planId),
       role = Value(role),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<ChatMessageRow> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ChatMessagesCompanion copyWith({
    Value<int>? id,
    Value<int>? planId,
    Value<String>? role,
    Value<String>? content,
    Value<DateTime>? createdAt,
  }) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StreaksTable extends Streaks with TableInfo<$StreaksTable, Streak> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreaksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _currentDaysMeta = const VerificationMeta(
    'currentDays',
  );
  @override
  late final GeneratedColumn<int> currentDays = GeneratedColumn<int>(
    'current_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestDaysMeta = const VerificationMeta(
    'longestDays',
  );
  @override
  late final GeneratedColumn<int> longestDays = GeneratedColumn<int>(
    'longest_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta(
    'lastActiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActiveDate =
      GeneratedColumn<DateTime>(
        'last_active_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _freezesRemainingMeta = const VerificationMeta(
    'freezesRemaining',
  );
  @override
  late final GeneratedColumn<int> freezesRemaining = GeneratedColumn<int>(
    'freezes_remaining',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currentDays,
    longestDays,
    lastActiveDate,
    freezesRemaining,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streaks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Streak> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_days')) {
      context.handle(
        _currentDaysMeta,
        currentDays.isAcceptableOrUnknown(
          data['current_days']!,
          _currentDaysMeta,
        ),
      );
    }
    if (data.containsKey('longest_days')) {
      context.handle(
        _longestDaysMeta,
        longestDays.isAcceptableOrUnknown(
          data['longest_days']!,
          _longestDaysMeta,
        ),
      );
    }
    if (data.containsKey('last_active_date')) {
      context.handle(
        _lastActiveDateMeta,
        lastActiveDate.isAcceptableOrUnknown(
          data['last_active_date']!,
          _lastActiveDateMeta,
        ),
      );
    }
    if (data.containsKey('freezes_remaining')) {
      context.handle(
        _freezesRemainingMeta,
        freezesRemaining.isAcceptableOrUnknown(
          data['freezes_remaining']!,
          _freezesRemainingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Streak map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Streak(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currentDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_days'],
      )!,
      longestDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_days'],
      )!,
      lastActiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_active_date'],
      ),
      freezesRemaining: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}freezes_remaining'],
      )!,
    );
  }

  @override
  $StreaksTable createAlias(String alias) {
    return $StreaksTable(attachedDatabase, alias);
  }
}

class Streak extends DataClass implements Insertable<Streak> {
  final int id;
  final int currentDays;
  final int longestDays;
  final DateTime? lastActiveDate;
  final int freezesRemaining;
  const Streak({
    required this.id,
    required this.currentDays,
    required this.longestDays,
    this.lastActiveDate,
    required this.freezesRemaining,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_days'] = Variable<int>(currentDays);
    map['longest_days'] = Variable<int>(longestDays);
    if (!nullToAbsent || lastActiveDate != null) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate);
    }
    map['freezes_remaining'] = Variable<int>(freezesRemaining);
    return map;
  }

  StreaksCompanion toCompanion(bool nullToAbsent) {
    return StreaksCompanion(
      id: Value(id),
      currentDays: Value(currentDays),
      longestDays: Value(longestDays),
      lastActiveDate: lastActiveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveDate),
      freezesRemaining: Value(freezesRemaining),
    );
  }

  factory Streak.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Streak(
      id: serializer.fromJson<int>(json['id']),
      currentDays: serializer.fromJson<int>(json['currentDays']),
      longestDays: serializer.fromJson<int>(json['longestDays']),
      lastActiveDate: serializer.fromJson<DateTime?>(json['lastActiveDate']),
      freezesRemaining: serializer.fromJson<int>(json['freezesRemaining']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentDays': serializer.toJson<int>(currentDays),
      'longestDays': serializer.toJson<int>(longestDays),
      'lastActiveDate': serializer.toJson<DateTime?>(lastActiveDate),
      'freezesRemaining': serializer.toJson<int>(freezesRemaining),
    };
  }

  Streak copyWith({
    int? id,
    int? currentDays,
    int? longestDays,
    Value<DateTime?> lastActiveDate = const Value.absent(),
    int? freezesRemaining,
  }) => Streak(
    id: id ?? this.id,
    currentDays: currentDays ?? this.currentDays,
    longestDays: longestDays ?? this.longestDays,
    lastActiveDate: lastActiveDate.present
        ? lastActiveDate.value
        : this.lastActiveDate,
    freezesRemaining: freezesRemaining ?? this.freezesRemaining,
  );
  Streak copyWithCompanion(StreaksCompanion data) {
    return Streak(
      id: data.id.present ? data.id.value : this.id,
      currentDays: data.currentDays.present
          ? data.currentDays.value
          : this.currentDays,
      longestDays: data.longestDays.present
          ? data.longestDays.value
          : this.longestDays,
      lastActiveDate: data.lastActiveDate.present
          ? data.lastActiveDate.value
          : this.lastActiveDate,
      freezesRemaining: data.freezesRemaining.present
          ? data.freezesRemaining.value
          : this.freezesRemaining,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Streak(')
          ..write('id: $id, ')
          ..write('currentDays: $currentDays, ')
          ..write('longestDays: $longestDays, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('freezesRemaining: $freezesRemaining')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currentDays,
    longestDays,
    lastActiveDate,
    freezesRemaining,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Streak &&
          other.id == this.id &&
          other.currentDays == this.currentDays &&
          other.longestDays == this.longestDays &&
          other.lastActiveDate == this.lastActiveDate &&
          other.freezesRemaining == this.freezesRemaining);
}

class StreaksCompanion extends UpdateCompanion<Streak> {
  final Value<int> id;
  final Value<int> currentDays;
  final Value<int> longestDays;
  final Value<DateTime?> lastActiveDate;
  final Value<int> freezesRemaining;
  const StreaksCompanion({
    this.id = const Value.absent(),
    this.currentDays = const Value.absent(),
    this.longestDays = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.freezesRemaining = const Value.absent(),
  });
  StreaksCompanion.insert({
    this.id = const Value.absent(),
    this.currentDays = const Value.absent(),
    this.longestDays = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.freezesRemaining = const Value.absent(),
  });
  static Insertable<Streak> custom({
    Expression<int>? id,
    Expression<int>? currentDays,
    Expression<int>? longestDays,
    Expression<DateTime>? lastActiveDate,
    Expression<int>? freezesRemaining,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentDays != null) 'current_days': currentDays,
      if (longestDays != null) 'longest_days': longestDays,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
      if (freezesRemaining != null) 'freezes_remaining': freezesRemaining,
    });
  }

  StreaksCompanion copyWith({
    Value<int>? id,
    Value<int>? currentDays,
    Value<int>? longestDays,
    Value<DateTime?>? lastActiveDate,
    Value<int>? freezesRemaining,
  }) {
    return StreaksCompanion(
      id: id ?? this.id,
      currentDays: currentDays ?? this.currentDays,
      longestDays: longestDays ?? this.longestDays,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      freezesRemaining: freezesRemaining ?? this.freezesRemaining,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentDays.present) {
      map['current_days'] = Variable<int>(currentDays.value);
    }
    if (longestDays.present) {
      map['longest_days'] = Variable<int>(longestDays.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    if (freezesRemaining.present) {
      map['freezes_remaining'] = Variable<int>(freezesRemaining.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreaksCompanion(')
          ..write('id: $id, ')
          ..write('currentDays: $currentDays, ')
          ..write('longestDays: $longestDays, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('freezesRemaining: $freezesRemaining')
          ..write(')'))
        .toString();
  }
}

class $GamificationEventsTable extends GamificationEvents
    with TableInfo<$GamificationEventsTable, GamificationEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GamificationEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventType, value, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gamification_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<GamificationEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GamificationEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GamificationEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GamificationEventsTable createAlias(String alias) {
    return $GamificationEventsTable(attachedDatabase, alias);
  }
}

class GamificationEvent extends DataClass
    implements Insertable<GamificationEvent> {
  final int id;
  final String eventType;
  final int value;
  final DateTime createdAt;
  const GamificationEvent({
    required this.id,
    required this.eventType,
    required this.value,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_type'] = Variable<String>(eventType);
    map['value'] = Variable<int>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GamificationEventsCompanion toCompanion(bool nullToAbsent) {
    return GamificationEventsCompanion(
      id: Value(id),
      eventType: Value(eventType),
      value: Value(value),
      createdAt: Value(createdAt),
    );
  }

  factory GamificationEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GamificationEvent(
      id: serializer.fromJson<int>(json['id']),
      eventType: serializer.fromJson<String>(json['eventType']),
      value: serializer.fromJson<int>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventType': serializer.toJson<String>(eventType),
      'value': serializer.toJson<int>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GamificationEvent copyWith({
    int? id,
    String? eventType,
    int? value,
    DateTime? createdAt,
  }) => GamificationEvent(
    id: id ?? this.id,
    eventType: eventType ?? this.eventType,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
  );
  GamificationEvent copyWithCompanion(GamificationEventsCompanion data) {
    return GamificationEvent(
      id: data.id.present ? data.id.value : this.id,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GamificationEvent(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventType, value, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GamificationEvent &&
          other.id == this.id &&
          other.eventType == this.eventType &&
          other.value == this.value &&
          other.createdAt == this.createdAt);
}

class GamificationEventsCompanion extends UpdateCompanion<GamificationEvent> {
  final Value<int> id;
  final Value<String> eventType;
  final Value<int> value;
  final Value<DateTime> createdAt;
  const GamificationEventsCompanion({
    this.id = const Value.absent(),
    this.eventType = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GamificationEventsCompanion.insert({
    this.id = const Value.absent(),
    required String eventType,
    required int value,
    required DateTime createdAt,
  }) : eventType = Value(eventType),
       value = Value(value),
       createdAt = Value(createdAt);
  static Insertable<GamificationEvent> custom({
    Expression<int>? id,
    Expression<String>? eventType,
    Expression<int>? value,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventType != null) 'event_type': eventType,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GamificationEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? eventType,
    Value<int>? value,
    Value<DateTime>? createdAt,
  }) {
    return GamificationEventsCompanion(
      id: id ?? this.id,
      eventType: eventType ?? this.eventType,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamificationEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionJsonMeta = const VerificationMeta(
    'conditionJson',
  );
  @override
  late final GeneratedColumn<String> conditionJson = GeneratedColumn<String>(
    'condition_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    name,
    description,
    icon,
    conditionJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Badge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('condition_json')) {
      context.handle(
        _conditionJsonMeta,
        conditionJson.isAcceptableOrUnknown(
          data['condition_json']!,
          _conditionJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conditionJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  Badge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Badge(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      conditionJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition_json'],
      )!,
    );
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(attachedDatabase, alias);
  }
}

class Badge extends DataClass implements Insertable<Badge> {
  final String code;
  final String name;
  final String description;
  final String icon;
  final String conditionJson;
  const Badge({
    required this.code,
    required this.name,
    required this.description,
    required this.icon,
    required this.conditionJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    map['condition_json'] = Variable<String>(conditionJson);
    return map;
  }

  BadgesCompanion toCompanion(bool nullToAbsent) {
    return BadgesCompanion(
      code: Value(code),
      name: Value(name),
      description: Value(description),
      icon: Value(icon),
      conditionJson: Value(conditionJson),
    );
  }

  factory Badge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Badge(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      conditionJson: serializer.fromJson<String>(json['conditionJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'conditionJson': serializer.toJson<String>(conditionJson),
    };
  }

  Badge copyWith({
    String? code,
    String? name,
    String? description,
    String? icon,
    String? conditionJson,
  }) => Badge(
    code: code ?? this.code,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    conditionJson: conditionJson ?? this.conditionJson,
  );
  Badge copyWithCompanion(BadgesCompanion data) {
    return Badge(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      conditionJson: data.conditionJson.present
          ? data.conditionJson.value
          : this.conditionJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Badge(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('conditionJson: $conditionJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name, description, icon, conditionJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Badge &&
          other.code == this.code &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.conditionJson == this.conditionJson);
}

class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> description;
  final Value<String> icon;
  final Value<String> conditionJson;
  final Value<int> rowid;
  const BadgesCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.conditionJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BadgesCompanion.insert({
    required String code,
    required String name,
    required String description,
    required String icon,
    required String conditionJson,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       description = Value(description),
       icon = Value(icon),
       conditionJson = Value(conditionJson);
  static Insertable<Badge> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? conditionJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (conditionJson != null) 'condition_json': conditionJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BadgesCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<String>? description,
    Value<String>? icon,
    Value<String>? conditionJson,
    Value<int>? rowid,
  }) {
    return BadgesCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      conditionJson: conditionJson ?? this.conditionJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (conditionJson.present) {
      map['condition_json'] = Variable<String>(conditionJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgesCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('conditionJson: $conditionJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $DayTasksTable dayTasks = $DayTasksTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $StreaksTable streaks = $StreaksTable(this);
  late final $GamificationEventsTable gamificationEvents =
      $GamificationEventsTable(this);
  late final $BadgesTable badges = $BadgesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    plans,
    dayTasks,
    chatMessages,
    streaks,
    gamificationEvents,
    badges,
  ];
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      required int age,
      required double heightCm,
      required double weightKg,
      required String sex,
      required String goal,
      required String experience,
      required String equipment,
      Value<String?> injuries,
      Value<String?> dietaryNotes,
      required String dailySchedule,
      required DateTime updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<int> age,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<String> sex,
      Value<String> goal,
      Value<String> experience,
      Value<String> equipment,
      Value<String?> injuries,
      Value<String?> dietaryNotes,
      Value<String> dailySchedule,
      Value<DateTime> updatedAt,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get injuries => $composableBuilder(
    column: $table.injuries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dietaryNotes => $composableBuilder(
    column: $table.dietaryNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dailySchedule => $composableBuilder(
    column: $table.dailySchedule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get injuries => $composableBuilder(
    column: $table.injuries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dietaryNotes => $composableBuilder(
    column: $table.dietaryNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dailySchedule => $composableBuilder(
    column: $table.dailySchedule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get injuries =>
      $composableBuilder(column: $table.injuries, builder: (column) => column);

  GeneratedColumn<String> get dietaryNotes => $composableBuilder(
    column: $table.dietaryNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dailySchedule => $composableBuilder(
    column: $table.dailySchedule,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfileRow,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfileRow,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>,
          ),
          UserProfileRow,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<String> experience = const Value.absent(),
                Value<String> equipment = const Value.absent(),
                Value<String?> injuries = const Value.absent(),
                Value<String?> dietaryNotes = const Value.absent(),
                Value<String> dailySchedule = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                age: age,
                heightCm: heightCm,
                weightKg: weightKg,
                sex: sex,
                goal: goal,
                experience: experience,
                equipment: equipment,
                injuries: injuries,
                dietaryNotes: dietaryNotes,
                dailySchedule: dailySchedule,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int age,
                required double heightCm,
                required double weightKg,
                required String sex,
                required String goal,
                required String experience,
                required String equipment,
                Value<String?> injuries = const Value.absent(),
                Value<String?> dietaryNotes = const Value.absent(),
                required String dailySchedule,
                required DateTime updatedAt,
              }) => UserProfilesCompanion.insert(
                id: id,
                age: age,
                heightCm: heightCm,
                weightKg: weightKg,
                sex: sex,
                goal: goal,
                experience: experience,
                equipment: equipment,
                injuries: injuries,
                dietaryNotes: dietaryNotes,
                dailySchedule: dailySchedule,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfileRow,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfileRow,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>,
      ),
      UserProfileRow,
      PrefetchHooks Function()
    >;
typedef $$PlansTableCreateCompanionBuilder =
    PlansCompanion Function({
      Value<int> id,
      required int version,
      required DateTime startDate,
      required int weeks,
      required String planJson,
      required DateTime createdAt,
      Value<bool> active,
    });
typedef $$PlansTableUpdateCompanionBuilder =
    PlansCompanion Function({
      Value<int> id,
      Value<int> version,
      Value<DateTime> startDate,
      Value<int> weeks,
      Value<String> planJson,
      Value<DateTime> createdAt,
      Value<bool> active,
    });

final class $$PlansTableReferences
    extends BaseReferences<_$AppDatabase, $PlansTable, PlanRow> {
  $$PlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DayTasksTable, List<DayTaskRow>>
  _dayTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dayTasks,
    aliasName: $_aliasNameGenerator(db.plans.id, db.dayTasks.planId),
  );

  $$DayTasksTableProcessedTableManager get dayTasksRefs {
    final manager = $$DayTasksTableTableManager(
      $_db,
      $_db.dayTasks,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dayTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessageRow>>
  _chatMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chatMessages,
    aliasName: $_aliasNameGenerator(db.plans.id, db.chatMessages.planId),
  );

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager(
      $_db,
      $_db.chatMessages,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planJson => $composableBuilder(
    column: $table.planJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dayTasksRefs(
    Expression<bool> Function($$DayTasksTableFilterComposer f) f,
  ) {
    final $$DayTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dayTasks,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DayTasksTableFilterComposer(
            $db: $db,
            $table: $db.dayTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> chatMessagesRefs(
    Expression<bool> Function($$ChatMessagesTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planJson => $composableBuilder(
    column: $table.planJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get weeks =>
      $composableBuilder(column: $table.weeks, builder: (column) => column);

  GeneratedColumn<String> get planJson =>
      $composableBuilder(column: $table.planJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  Expression<T> dayTasksRefs<T extends Object>(
    Expression<T> Function($$DayTasksTableAnnotationComposer a) f,
  ) {
    final $$DayTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dayTasks,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DayTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.dayTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> chatMessagesRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlansTable,
          PlanRow,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (PlanRow, $$PlansTableReferences),
          PlanRow,
          PrefetchHooks Function({bool dayTasksRefs, bool chatMessagesRefs})
        > {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> weeks = const Value.absent(),
                Value<String> planJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> active = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                version: version,
                startDate: startDate,
                weeks: weeks,
                planJson: planJson,
                createdAt: createdAt,
                active: active,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int version,
                required DateTime startDate,
                required int weeks,
                required String planJson,
                required DateTime createdAt,
                Value<bool> active = const Value.absent(),
              }) => PlansCompanion.insert(
                id: id,
                version: version,
                startDate: startDate,
                weeks: weeks,
                planJson: planJson,
                createdAt: createdAt,
                active: active,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlansTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({dayTasksRefs = false, chatMessagesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dayTasksRefs) db.dayTasks,
                    if (chatMessagesRefs) db.chatMessages,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dayTasksRefs)
                        await $_getPrefetchedData<
                          PlanRow,
                          $PlansTable,
                          DayTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlansTableReferences
                              ._dayTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlansTableReferences(
                                db,
                                table,
                                p0,
                              ).dayTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (chatMessagesRefs)
                        await $_getPrefetchedData<
                          PlanRow,
                          $PlansTable,
                          ChatMessageRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlansTableReferences
                              ._chatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlansTableReferences(
                                db,
                                table,
                                p0,
                              ).chatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlansTable,
      PlanRow,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (PlanRow, $$PlansTableReferences),
      PlanRow,
      PrefetchHooks Function({bool dayTasksRefs, bool chatMessagesRefs})
    >;
typedef $$DayTasksTableCreateCompanionBuilder =
    DayTasksCompanion Function({
      Value<int> id,
      required int planId,
      required int dayIndex,
      required DateTime date,
      required String workoutJson,
      required String mealsJson,
      Value<bool> completedWorkout,
      Value<String> completedMeals,
      Value<int> xpAwarded,
      Value<DateTime?> completedAt,
    });
typedef $$DayTasksTableUpdateCompanionBuilder =
    DayTasksCompanion Function({
      Value<int> id,
      Value<int> planId,
      Value<int> dayIndex,
      Value<DateTime> date,
      Value<String> workoutJson,
      Value<String> mealsJson,
      Value<bool> completedWorkout,
      Value<String> completedMeals,
      Value<int> xpAwarded,
      Value<DateTime?> completedAt,
    });

final class $$DayTasksTableReferences
    extends BaseReferences<_$AppDatabase, $DayTasksTable, DayTaskRow> {
  $$DayTasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlansTable _planIdTable(_$AppDatabase db) => db.plans.createAlias(
    $_aliasNameGenerator(db.dayTasks.planId, db.plans.id),
  );

  $$PlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$PlansTableTableManager(
      $_db,
      $_db.plans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DayTasksTableFilterComposer
    extends Composer<_$AppDatabase, $DayTasksTable> {
  $$DayTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayIndex => $composableBuilder(
    column: $table.dayIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutJson => $composableBuilder(
    column: $table.workoutJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealsJson => $composableBuilder(
    column: $table.mealsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completedWorkout => $composableBuilder(
    column: $table.completedWorkout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedMeals => $composableBuilder(
    column: $table.completedMeals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlansTableFilterComposer get planId {
    final $$PlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableFilterComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DayTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $DayTasksTable> {
  $$DayTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayIndex => $composableBuilder(
    column: $table.dayIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutJson => $composableBuilder(
    column: $table.workoutJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealsJson => $composableBuilder(
    column: $table.mealsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completedWorkout => $composableBuilder(
    column: $table.completedWorkout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedMeals => $composableBuilder(
    column: $table.completedMeals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlansTableOrderingComposer get planId {
    final $$PlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableOrderingComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DayTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayTasksTable> {
  $$DayTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayIndex =>
      $composableBuilder(column: $table.dayIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get workoutJson => $composableBuilder(
    column: $table.workoutJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mealsJson =>
      $composableBuilder(column: $table.mealsJson, builder: (column) => column);

  GeneratedColumn<bool> get completedWorkout => $composableBuilder(
    column: $table.completedWorkout,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedMeals => $composableBuilder(
    column: $table.completedMeals,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpAwarded =>
      $composableBuilder(column: $table.xpAwarded, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$PlansTableAnnotationComposer get planId {
    final $$PlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableAnnotationComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DayTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayTasksTable,
          DayTaskRow,
          $$DayTasksTableFilterComposer,
          $$DayTasksTableOrderingComposer,
          $$DayTasksTableAnnotationComposer,
          $$DayTasksTableCreateCompanionBuilder,
          $$DayTasksTableUpdateCompanionBuilder,
          (DayTaskRow, $$DayTasksTableReferences),
          DayTaskRow,
          PrefetchHooks Function({bool planId})
        > {
  $$DayTasksTableTableManager(_$AppDatabase db, $DayTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int> dayIndex = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> workoutJson = const Value.absent(),
                Value<String> mealsJson = const Value.absent(),
                Value<bool> completedWorkout = const Value.absent(),
                Value<String> completedMeals = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => DayTasksCompanion(
                id: id,
                planId: planId,
                dayIndex: dayIndex,
                date: date,
                workoutJson: workoutJson,
                mealsJson: mealsJson,
                completedWorkout: completedWorkout,
                completedMeals: completedMeals,
                xpAwarded: xpAwarded,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planId,
                required int dayIndex,
                required DateTime date,
                required String workoutJson,
                required String mealsJson,
                Value<bool> completedWorkout = const Value.absent(),
                Value<String> completedMeals = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => DayTasksCompanion.insert(
                id: id,
                planId: planId,
                dayIndex: dayIndex,
                date: date,
                workoutJson: workoutJson,
                mealsJson: mealsJson,
                completedWorkout: completedWorkout,
                completedMeals: completedMeals,
                xpAwarded: xpAwarded,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DayTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$DayTasksTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$DayTasksTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DayTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayTasksTable,
      DayTaskRow,
      $$DayTasksTableFilterComposer,
      $$DayTasksTableOrderingComposer,
      $$DayTasksTableAnnotationComposer,
      $$DayTasksTableCreateCompanionBuilder,
      $$DayTasksTableUpdateCompanionBuilder,
      (DayTaskRow, $$DayTasksTableReferences),
      DayTaskRow,
      PrefetchHooks Function({bool planId})
    >;
typedef $$ChatMessagesTableCreateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      required int planId,
      required String role,
      required String content,
      required DateTime createdAt,
    });
typedef $$ChatMessagesTableUpdateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      Value<int> planId,
      Value<String> role,
      Value<String> content,
      Value<DateTime> createdAt,
    });

final class $$ChatMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessageRow> {
  $$ChatMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlansTable _planIdTable(_$AppDatabase db) => db.plans.createAlias(
    $_aliasNameGenerator(db.chatMessages.planId, db.plans.id),
  );

  $$PlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$PlansTableTableManager(
      $_db,
      $_db.plans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlansTableFilterComposer get planId {
    final $$PlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableFilterComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlansTableOrderingComposer get planId {
    final $$PlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableOrderingComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlansTableAnnotationComposer get planId {
    final $$PlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableAnnotationComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatMessagesTable,
          ChatMessageRow,
          $$ChatMessagesTableFilterComposer,
          $$ChatMessagesTableOrderingComposer,
          $$ChatMessagesTableAnnotationComposer,
          $$ChatMessagesTableCreateCompanionBuilder,
          $$ChatMessagesTableUpdateCompanionBuilder,
          (ChatMessageRow, $$ChatMessagesTableReferences),
          ChatMessageRow,
          PrefetchHooks Function({bool planId})
        > {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ChatMessagesCompanion(
                id: id,
                planId: planId,
                role: role,
                content: content,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planId,
                required String role,
                required String content,
                required DateTime createdAt,
              }) => ChatMessagesCompanion.insert(
                id: id,
                planId: planId,
                role: role,
                content: content,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$ChatMessagesTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$ChatMessagesTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatMessagesTable,
      ChatMessageRow,
      $$ChatMessagesTableFilterComposer,
      $$ChatMessagesTableOrderingComposer,
      $$ChatMessagesTableAnnotationComposer,
      $$ChatMessagesTableCreateCompanionBuilder,
      $$ChatMessagesTableUpdateCompanionBuilder,
      (ChatMessageRow, $$ChatMessagesTableReferences),
      ChatMessageRow,
      PrefetchHooks Function({bool planId})
    >;
typedef $$StreaksTableCreateCompanionBuilder =
    StreaksCompanion Function({
      Value<int> id,
      Value<int> currentDays,
      Value<int> longestDays,
      Value<DateTime?> lastActiveDate,
      Value<int> freezesRemaining,
    });
typedef $$StreaksTableUpdateCompanionBuilder =
    StreaksCompanion Function({
      Value<int> id,
      Value<int> currentDays,
      Value<int> longestDays,
      Value<DateTime?> lastActiveDate,
      Value<int> freezesRemaining,
    });

class $$StreaksTableFilterComposer
    extends Composer<_$AppDatabase, $StreaksTable> {
  $$StreaksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentDays => $composableBuilder(
    column: $table.currentDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestDays => $composableBuilder(
    column: $table.longestDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get freezesRemaining => $composableBuilder(
    column: $table.freezesRemaining,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StreaksTableOrderingComposer
    extends Composer<_$AppDatabase, $StreaksTable> {
  $$StreaksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentDays => $composableBuilder(
    column: $table.currentDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestDays => $composableBuilder(
    column: $table.longestDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get freezesRemaining => $composableBuilder(
    column: $table.freezesRemaining,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StreaksTableAnnotationComposer
    extends Composer<_$AppDatabase, $StreaksTable> {
  $$StreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentDays => $composableBuilder(
    column: $table.currentDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestDays => $composableBuilder(
    column: $table.longestDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get freezesRemaining => $composableBuilder(
    column: $table.freezesRemaining,
    builder: (column) => column,
  );
}

class $$StreaksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StreaksTable,
          Streak,
          $$StreaksTableFilterComposer,
          $$StreaksTableOrderingComposer,
          $$StreaksTableAnnotationComposer,
          $$StreaksTableCreateCompanionBuilder,
          $$StreaksTableUpdateCompanionBuilder,
          (Streak, BaseReferences<_$AppDatabase, $StreaksTable, Streak>),
          Streak,
          PrefetchHooks Function()
        > {
  $$StreaksTableTableManager(_$AppDatabase db, $StreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentDays = const Value.absent(),
                Value<int> longestDays = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
                Value<int> freezesRemaining = const Value.absent(),
              }) => StreaksCompanion(
                id: id,
                currentDays: currentDays,
                longestDays: longestDays,
                lastActiveDate: lastActiveDate,
                freezesRemaining: freezesRemaining,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentDays = const Value.absent(),
                Value<int> longestDays = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
                Value<int> freezesRemaining = const Value.absent(),
              }) => StreaksCompanion.insert(
                id: id,
                currentDays: currentDays,
                longestDays: longestDays,
                lastActiveDate: lastActiveDate,
                freezesRemaining: freezesRemaining,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StreaksTable,
      Streak,
      $$StreaksTableFilterComposer,
      $$StreaksTableOrderingComposer,
      $$StreaksTableAnnotationComposer,
      $$StreaksTableCreateCompanionBuilder,
      $$StreaksTableUpdateCompanionBuilder,
      (Streak, BaseReferences<_$AppDatabase, $StreaksTable, Streak>),
      Streak,
      PrefetchHooks Function()
    >;
typedef $$GamificationEventsTableCreateCompanionBuilder =
    GamificationEventsCompanion Function({
      Value<int> id,
      required String eventType,
      required int value,
      required DateTime createdAt,
    });
typedef $$GamificationEventsTableUpdateCompanionBuilder =
    GamificationEventsCompanion Function({
      Value<int> id,
      Value<String> eventType,
      Value<int> value,
      Value<DateTime> createdAt,
    });

class $$GamificationEventsTableFilterComposer
    extends Composer<_$AppDatabase, $GamificationEventsTable> {
  $$GamificationEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GamificationEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $GamificationEventsTable> {
  $$GamificationEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GamificationEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GamificationEventsTable> {
  $$GamificationEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GamificationEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GamificationEventsTable,
          GamificationEvent,
          $$GamificationEventsTableFilterComposer,
          $$GamificationEventsTableOrderingComposer,
          $$GamificationEventsTableAnnotationComposer,
          $$GamificationEventsTableCreateCompanionBuilder,
          $$GamificationEventsTableUpdateCompanionBuilder,
          (
            GamificationEvent,
            BaseReferences<
              _$AppDatabase,
              $GamificationEventsTable,
              GamificationEvent
            >,
          ),
          GamificationEvent,
          PrefetchHooks Function()
        > {
  $$GamificationEventsTableTableManager(
    _$AppDatabase db,
    $GamificationEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GamificationEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GamificationEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GamificationEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GamificationEventsCompanion(
                id: id,
                eventType: eventType,
                value: value,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String eventType,
                required int value,
                required DateTime createdAt,
              }) => GamificationEventsCompanion.insert(
                id: id,
                eventType: eventType,
                value: value,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GamificationEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GamificationEventsTable,
      GamificationEvent,
      $$GamificationEventsTableFilterComposer,
      $$GamificationEventsTableOrderingComposer,
      $$GamificationEventsTableAnnotationComposer,
      $$GamificationEventsTableCreateCompanionBuilder,
      $$GamificationEventsTableUpdateCompanionBuilder,
      (
        GamificationEvent,
        BaseReferences<
          _$AppDatabase,
          $GamificationEventsTable,
          GamificationEvent
        >,
      ),
      GamificationEvent,
      PrefetchHooks Function()
    >;
typedef $$BadgesTableCreateCompanionBuilder =
    BadgesCompanion Function({
      required String code,
      required String name,
      required String description,
      required String icon,
      required String conditionJson,
      Value<int> rowid,
    });
typedef $$BadgesTableUpdateCompanionBuilder =
    BadgesCompanion Function({
      Value<String> code,
      Value<String> name,
      Value<String> description,
      Value<String> icon,
      Value<String> conditionJson,
      Value<int> rowid,
    });

class $$BadgesTableFilterComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionJson => $composableBuilder(
    column: $table.conditionJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BadgesTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionJson => $composableBuilder(
    column: $table.conditionJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BadgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get conditionJson => $composableBuilder(
    column: $table.conditionJson,
    builder: (column) => column,
  );
}

class $$BadgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BadgesTable,
          Badge,
          $$BadgesTableFilterComposer,
          $$BadgesTableOrderingComposer,
          $$BadgesTableAnnotationComposer,
          $$BadgesTableCreateCompanionBuilder,
          $$BadgesTableUpdateCompanionBuilder,
          (Badge, BaseReferences<_$AppDatabase, $BadgesTable, Badge>),
          Badge,
          PrefetchHooks Function()
        > {
  $$BadgesTableTableManager(_$AppDatabase db, $BadgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BadgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BadgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BadgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> conditionJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BadgesCompanion(
                code: code,
                name: name,
                description: description,
                icon: icon,
                conditionJson: conditionJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String name,
                required String description,
                required String icon,
                required String conditionJson,
                Value<int> rowid = const Value.absent(),
              }) => BadgesCompanion.insert(
                code: code,
                name: name,
                description: description,
                icon: icon,
                conditionJson: conditionJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BadgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BadgesTable,
      Badge,
      $$BadgesTableFilterComposer,
      $$BadgesTableOrderingComposer,
      $$BadgesTableAnnotationComposer,
      $$BadgesTableCreateCompanionBuilder,
      $$BadgesTableUpdateCompanionBuilder,
      (Badge, BaseReferences<_$AppDatabase, $BadgesTable, Badge>),
      Badge,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$DayTasksTableTableManager get dayTasks =>
      $$DayTasksTableTableManager(_db, _db.dayTasks);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$StreaksTableTableManager get streaks =>
      $$StreaksTableTableManager(_db, _db.streaks);
  $$GamificationEventsTableTableManager get gamificationEvents =>
      $$GamificationEventsTableTableManager(_db, _db.gamificationEvents);
  $$BadgesTableTableManager get badges =>
      $$BadgesTableTableManager(_db, _db.badges);
}
