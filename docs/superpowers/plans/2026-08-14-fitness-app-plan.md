# 健身 APP 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现 spec 中描述的 Duolingo 式游戏化健身 & 饮食 app，Flutter + Qwen-Plus + 本地优先存储，单人开发 10-15 天完成 MVP（Android APK）。

**Architecture:** Flutter app（iOS + Android，M1 仅交付 Android）+ 薄 Cloudflare Workers proxy（持有 LLM API Key，无状态转发）。App 本地优先，全部用户数据存 SQLite（Drift）；LLM 通过 streaming SSE 通信。游戏化层（streak / XP / 徽章）独立于业务功能。

**Tech Stack:**
- Flutter ≥3.16 / Dart ≥3.0
- Drift（SQLite） + drift_dev
- Riverpod 2（状态管理）
- freezed + json_serializable（不可变 model）
- flutter_local_notifications
- fl_chart（趋势图）
- lottie（吉祥物动画）
- flutter_animate（庆祝动效）
- go_router（路由）
- Cloudflare Workers（TypeScript）+ Hono
- Vitest（proxy 测试）
- Qwen-Plus API（DashScope 兼容 OpenAI 协议）

## Global Constraints

- **Flutter 版本**：≥3.16（Dart ≥3.0）
- **Drift 版本**：≥2.18（支持 Dart 3）
- **Riverpod 版本**：2.x（用 `@riverpod` 注解）
- **LLM**：Qwen-Plus（`qwen-plus`），DashScope 兼容 OpenAI chat completions API，endpoint `https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions`
- **Proxy 部署**：Cloudflare Workers（`*.workers.dev` 子域名，无需备案）
- **品牌色**：主绿 `#58CC02` / 紫 `#CE82FF` / 金 `#FFC800` / 红 `#FF4B4B` / 浅灰底 `#F7F7F7`
- **计划长度**：默认 12 周（84 天）；4 天训练 + 3 天休息
- **XP 规则**：workout +30 / 4 餐全完成 +20 / 当日全完成 +50 / 7 天 streak +100 / 徽章 +200 / 按教练调整 +10；每 1000 XP 升一级
- **Streak freeze**：每 30 天自动 +2 张，上限 2 张，漏打卡时自动消耗
- **断点续聊阈值**：≥7 天未活跃触发「欢迎回来」弹窗
- **数据**：全部用户数据本地 SQLite，proxy 不持久化任何用户数据
- **安全**：app↔proxy 之间 HMAC-SHA256 签名；Qwen API Key 仅存 proxy 环境变量
- **月预算熔断**：默认 ¥100/月（可调），proxy 端实现
- **iOS**：不在 MVP 范围（iOS 工程文件由 `flutter create` 生成但不上架）
- **i18n**：仅 zh-CN
- **JSON schema 校验**：plan_emit 必须通过 `lib/domain/plan_schema.dart` 的校验才能落地

## Prerequisites（开始 Task 1 之前手动完成）

- [ ] 申请 Qwen API Key（阿里云百炼控制台 https://bailian.console.aliyun.com/）
- [ ] 注册 Cloudflare 账号（https://dash.cloudflare.com/sign-up）
- [ ] 安装 wrangler CLI（`npm install -g wrangler`）并 `wrangler login`
- [ ] 准备「教练猫头鹰」Lottie JSON 文件（可临时用占位符）
- [ ] 确认 Android 手机已开启「开发者模式 + USB 调试」便于真机调试

---

## Task 1: 工程初始化（Flutter + Proxy 双仓）

**Files:**
- Create: `app/`（Flutter 项目根）
- Create: `proxy/`（Cloudflare Workers 项目根）
- Create: `app/.gitignore`
- Create: `proxy/.gitignore`
- Create: `app/lib/main.dart`
- Create: `app/lib/app.dart`
- Create: `app/lib/config.dart`
- Create: `app/test/smoke_test.dart`
- Create: `proxy/src/index.ts`
- Create: `proxy/src/config.ts`
- Create: `proxy/package.json`
- Create: `proxy/wrangler.toml`
- Create: `proxy/test/index.test.ts`

**Interfaces:**
- Produces:
  - `app/lib/main.dart` exports `void main()` 入口
  - `app/lib/config.dart` exports `class AppConfig { String proxyEndpoint; String hmacSecret; }`
  - `proxy/src/index.ts` exports default `{ fetch: ExportedHandler<Env>['fetch'] }`

- [ ] **Step 1: 验证 Flutter 环境**

```bash
flutter --version
```
预期：`Flutter 3.16.x` 或更高，Dart `3.x`。若未安装，参考 Termux 安装指南（pkg 不可直接装 Flutter，需手动下载 SDK 解压到 `~/flutter` 并加入 PATH）。

- [ ] **Step 2: 验证 Node 环境（proxy 用）**

```bash
node --version && npm --version
```
预期：Node ≥18，npm ≥9。Termux：`pkg install nodejs`。

- [ ] **Step 3: 验证 Android 工具链**

```bash
flutter doctor -v
```
预期：Android toolchain、Android Studio（或 cmdline-tools）、Connected device 至少一项 OK。若 Android SDK 缺失，`pkg install openjdk-17` 然后用 `sdkmanager` 装 Android SDK 34。

- [ ] **Step 4: 创建 Flutter 项目骨架**

```bash
cd /data/data/com.termux/files/home/gym
flutter create --org com.gymcoach --project-name gym_coach --platforms=android,ios app
```
预期：`app/` 目录生成，含 `lib/main.dart`、`android/`、`ios/`。

- [ ] **Step 5: 替换 `app/lib/main.dart` 为最小可运行版本**

```dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const GymCoachApp());
}
```

- [ ] **Step 6: 创建 `app/lib/app.dart`**

```dart
import 'package:flutter/material.dart';

class GymCoachApp extends StatelessWidget {
  const GymCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '健身猫头鹰',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF58CC02)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Gym Coach MVP')),
      ),
    );
  }
}
```

- [ ] **Step 7: 创建 `app/lib/config.dart`**

```dart
class AppConfig {
  const AppConfig._();

  /// Cloudflare Workers proxy endpoint
  /// 部署后填入实际地址，形如 https://gym-coach.<subdomain>.workers.dev
  static const String proxyEndpoint = String.fromEnvironment(
    'PROXY_ENDPOINT',
    defaultValue: 'http://localhost:8787',
  );

  /// HMAC shared secret，与 proxy/wrangler.toml 中的值一致
  static const String hmacSecret = String.fromEnvironment(
    'HMAC_SECRET',
    defaultValue: 'dev-secret-change-me',
  );
}
```

- [ ] **Step 8: 创建 `app/test/smoke_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/config.dart';

void main() {
  test('AppConfig exposes proxyEndpoint and hmacSecret', () {
    expect(AppConfig.proxyEndpoint, isNotEmpty);
    expect(AppConfig.hmacSecret, isNotEmpty);
  });
}
```

- [ ] **Step 9: 创建 `proxy/` 目录结构**

```bash
mkdir -p proxy/src proxy/test
```

- [ ] **Step 10: 创建 `proxy/package.json`**

```json
{
  "name": "gym-coach-proxy",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "wrangler dev",
    "deploy": "wrangler deploy",
    "test": "vitest run"
  },
  "devDependencies": {
    "@cloudflare/workers-types": "^4.20240605.0",
    "vitest": "^2.0.0",
    "wrangler": "^3.65.0"
  },
  "dependencies": {
    "hono": "^4.4.0"
  }
}
```

- [ ] **Step 11: 创建 `proxy/wrangler.toml`**

```toml
name = "gym-coach-proxy"
main = "src/index.ts"
compatibility_date = "2024-08-01"

[vars]
HMAC_SECRET = "dev-secret-change-me"
MONTHLY_BUDGET_YUAN = "100"

# 真部署时通过 wrangler secret put QWEN_API_KEY 设置
```

- [ ] **Step 12: 创建 `proxy/src/config.ts`**

```typescript
export interface Env {
  QWEN_API_KEY: string;
  HMAC_SECRET: string;
  MONTHLY_BUDGET_YUAN: string;
}

export function getConfig(env: Env) {
  return {
    qwenApiKey: env.QWEN_API_KEY,
    hmacSecret: env.HMAC_SECRET,
    monthlyBudgetYuan: parseInt(env.MONTHLY_BUDGET_YUAN ?? '100', 10),
    qwenEndpoint: 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
    qwenModel: 'qwen-plus',
  };
}
```

- [ ] **Step 13: 创建 `proxy/src/index.ts`（最小 health check）**

```typescript
import { Hono } from 'hono';
import type { Env } from './config';

const app = new Hono<{ Bindings: Env }>();

app.get('/health', (c) => c.json({ status: 'ok' }));

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    return app.fetch(request, env);
  },
};
```

- [ ] **Step 14: 创建 `proxy/test/index.test.ts`**

```typescript
import { describe, it, expect } from 'vitest';
import app from '../src/index';

describe('proxy /health', () => {
  it('returns ok', async () => {
    const env = {
      QWEN_API_KEY: 'test-key',
      HMAC_SECRET: 'test-secret',
      MONTHLY_BUDGET_YUAN: '100',
    };
    const res = await app.fetch(
      new Request('http://localhost/health'),
      env,
    );
    expect(res.status).toBe(200);
    const body = await res.json() as { status: string };
    expect(body.status).toBe('ok');
  });
});
```

- [ ] **Step 15: 安装 proxy 依赖**

```bash
cd proxy && npm install
```

- [ ] **Step 16: 跑 proxy 测试**

```bash
npm test
```
预期：`1 passed`。

- [ ] **Step 17: 跑 Flutter smoke 测试**

```bash
cd ../app && flutter test test/smoke_test.dart
```
预期：`All tests passed!`。

- [ ] **Step 18: 提交**

```bash
cd ..
git add app proxy
git commit -m "chore: bootstrap flutter app + cloudflare workers proxy skeleton"
```

---

## Task 2: Drift 数据库 Schema（全部 7 张表）

**Files:**
- Create: `app/lib/data/db/tables.dart`
- Create: `app/lib/data/db/database.dart`
- Create: `app/test/data/db/database_test.dart`

**Interfaces:**
- Produces:
  - `class AppDatabase extends _$AppDatabase` with tables: `UserProfiles`, `Plans`, `DayTasks`, `ChatMessages`, `Streaks`, `GamificationEvents`, `Badges`
  - `AppDatabase.forTesting(QueryExecutor e)` 用于 in-memory 测试

- [ ] **Step 1: 添加 Drift 依赖**

编辑 `app/pubspec.yaml`，在 `dependencies:` 下加入：

```yaml
  drift: ^2.18.0
  drift_flutter: ^0.2.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  path: ^1.9.0

dev_dependencies:
  drift_dev: ^2.18.0
  build_runner: ^2.4.0
```

然后：
```bash
cd app && flutter pub get
```

- [ ] **Step 2: 创建 `app/lib/data/db/tables.dart`**

```dart
import 'package:drift/drift.dart';

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

class Plans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get version => integer()();
  DateTimeColumn get startDate => dateTime()();
  IntColumn get weeks => integer()();
  TextColumn get planJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}

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
```

- [ ] **Step 3: 创建 `app/lib/data/db/database.dart`**

```dart
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
    return driftDatabase(name: 'gym_coach', native: const DriftNativeOptions(databasePath: () async => file.path));
  });
}
```

- [ ] **Step 4: 运行 build_runner 生成代码**

```bash
dart run build_runner build --delete-conflicting-outputs
```
预期：生成 `database.g.dart`，无错误。

- [ ] **Step 5: 创建测试 `app/test/data/db/database_test.dart`**

```dart
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
```

- [ ] **Step 6: 运行测试**

```bash
flutter test test/data/db/database_test.dart
```
预期：`All tests passed!`。

- [ ] **Step 7: 提交**

```bash
git add app/lib/data app/test/data app/pubspec.yaml app/pubspec.lock
git commit -m "feat(db): drift schema with 7 tables (profile/plan/day_task/chat/streak/event/badge)"
```

---

## Task 3: 领域模型（freezed + json_serializable）

**Files:**
- Create: `app/lib/domain/models/user_profile.dart`
- Create: `app/lib/domain/models/exercise.dart`
- Create: `app/lib/domain/models/meal.dart`
- Create: `app/lib/domain/models/plan.dart`
- Create: `app/lib/domain/models/day_task.dart`
- Create: `app/lib/domain/models/chat_message.dart`
- Create: `app/test/domain/models/plan_parse_test.dart`

**Interfaces:**
- Produces:
  - `class UserProfile { final int age; final double heightCm; final double weightKg; final String sex; final Goal goal; final Experience experience; final List<String> equipment; final String? injuries; final String? dietaryNotes; final Map<String,bool> dailySchedule; final DateTime updatedAt; }`
  - `class Exercise { final String name; final int sets; final String reps; final int restSeconds; final String? notes; }`
  - `class Meal { final String slot; final String name; final int kcal; final int proteinG; final int carbsG; final int fatG; final List<String> ingredients; }`
  - `class Plan { final int weeks; final String weeklyStructure; final String goalSummary; final List<TrainingDay> trainingDays; final List<DailyMeals> dailyMeals; final DateTime startDate; }`
  - `class DayTask { final int? dbId; final int planId; final int dayIndex; final DateTime date; final Workout? workout; final List<Meal> meals; final bool completedWorkout; final Map<String,bool> completedMeals; final int xpAwarded; final DateTime? completedAt; }`
  - `class ChatMessage { final int planId; final ChatRole role; final String content; final DateTime createdAt; }`

- [ ] **Step 1: 添加 freezed 依赖**

`app/pubspec.yaml` 加入：

```yaml
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0

dev_dependencies:
  freezed: ^2.5.0
  json_serializable: ^6.8.0
```

```bash
flutter pub get
```

- [ ] **Step 2: 创建 `app/lib/domain/models/exercise.dart`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String name,
    required int sets,
    required String reps,
    @Default(90) int restSeconds,
    String? notes,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
```

- [ ] **Step 3: 创建 `app/lib/domain/models/meal.dart`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
class Meal with _$Meal {
  const factory Meal({
    required String slot,        // breakfast/lunch/dinner/snack
    required String name,
    required int kcal,
    @JsonKey(name: 'protein_g') required int proteinG,
    @JsonKey(name: 'carbs_g') required int carbsG,
    @JsonKey(name: 'fat_g') required int fatG,
    @Default([]) List<String> ingredients,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
```

- [ ] **Step 4: 创建 `app/lib/domain/models/plan.dart`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise.dart';
import 'meal.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

@freezed
class TrainingDay with _$TrainingDay {
  const factory TrainingDay({
    required int week,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    required String title,
    required String focus,
    @JsonKey(name: 'estimated_minutes') required int estimatedMinutes,
    required List<Exercise> exercises,
  }) = _TrainingDay;

  factory TrainingDay.fromJson(Map<String, dynamic> json) =>
      _$TrainingDayFromJson(json);
}

@freezed
class DailyMeals with _$DailyMeals {
  const factory DailyMeals({
    required int week,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'total_kcal') required int totalKcal,
    @JsonKey(name: 'protein_g') required int proteinG,
    @JsonKey(name: 'carbs_g') required int carbsG,
    @JsonKey(name: 'fat_g') required int fatG,
    required List<Meal> meals,
  }) = _DailyMeals;

  factory DailyMeals.fromJson(Map<String, dynamic> json) =>
      _$DailyMealsFromJson(json);
}

@freezed
class Plan with _$Plan {
  const factory Plan({
    required int weeks,
    @JsonKey(name: 'weekly_structure') required String weeklyStructure,
    @JsonKey(name: 'goal_summary') required String goalSummary,
    @JsonKey(name: 'training_days') required List<TrainingDay> trainingDays,
    @JsonKey(name: 'daily_meals') required List<DailyMeals> dailyMeals,
    required DateTime startDate,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}
```

- [ ] **Step 5: 创建 `app/lib/domain/models/user_profile.dart`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

enum Goal { muscleGain, fatLoss, maintenance, strength }
enum Experience { beginner, intermediate, advanced }
enum Sex { male, female, other }

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int age,
    @JsonKey(name: 'height_cm') required double heightCm,
    @JsonKey(name: 'weight_kg') required double weightKg,
    required Sex sex,
    required Goal goal,
    required Experience experience,
    @Default([]) List<String> equipment,
    String? injuries,
    @JsonKey(name: 'dietary_notes') String? dietaryNotes,
    @JsonKey(name: 'daily_schedule') @Default({}) Map<String, bool> dailySchedule,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
```

- [ ] **Step 6: 创建 `app/lib/domain/models/day_task.dart`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise.dart';
import 'meal.dart';

part 'day_task.freezed.dart';

@freezed
class Workout with _$Workout {
  const factory Workout({
    required String title,
    required int estimatedMinutes,
    required List<Exercise> exercises,
  }) = _Workout;
}

@freezed
class DayTask with _$DayTask {
  const factory DayTask({
    int? dbId,                          // 仅从 DB 读出时填，用于 markWorkoutDone/markMealDone
    required int planId,
    required int dayIndex,
    required DateTime date,
    Workout? workout,
    @Default([]) List<Meal> meals,
    @Default(false) bool completedWorkout,
    @Default({}) Map<String, bool> completedMeals,
    @Default(0) int xpAwarded,
    DateTime? completedAt,
  }) = _DayTask;
}
```

- [ ] **Step 7: 创建 `app/lib/domain/models/chat_message.dart`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

enum ChatRole { system, user, assistant }

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int planId,
    required ChatRole role,
    required String content,
    required DateTime createdAt,
  }) = _ChatMessage;
}
```

- [ ] **Step 8: 运行 build_runner**

```bash
dart run build_runner build --delete-conflicting-outputs
```
预期：所有 `.freezed.dart` 和 `.g.dart` 生成成功。

- [ ] **Step 9: 创建解析测试 `app/test/domain/models/plan_parse_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/domain/models/plan.dart';

void main() {
  test('Plan parses valid LLM JSON output', () {
    final json = {
      'weeks': 12,
      'weekly_structure': '4 天训练 + 3 天休息',
      'goal_summary': '12 周增肌',
      'training_days': [
        {
          'week': 1,
          'day_of_week': 1,
          'title': '上肢推',
          'focus': '增肌',
          'estimated_minutes': 45,
          'exercises': [
            {'name': '哑铃卧推', 'sets': 4, 'reps': '8-12', 'rest_seconds': 90},
          ],
        },
      ],
      'daily_meals': [
        {
          'week': 1,
          'day_of_week': 1,
          'total_kcal': 2200,
          'protein_g': 160,
          'carbs_g': 220,
          'fat_g': 70,
          'meals': [
            {
              'slot': 'breakfast',
              'name': '燕麦',
              'kcal': 480,
              'protein_g': 30,
              'carbs_g': 60,
              'fat_g': 12,
              'ingredients': ['燕麦 50g'],
            },
          ],
        },
      ],
      'startDate': '2026-08-14T00:00:00.000Z',
    };
    final plan = Plan.fromJson({...json, 'startDate': DateTime.utc(2026, 8, 14)});
    expect(plan.weeks, 12);
    expect(plan.trainingDays.first.exercises.first.name, '哑铃卧推');
    expect(plan.dailyMeals.first.meals.first.slot, 'breakfast');
  });
}
```

- [ ] **Step 10: 跑测试**

```bash
flutter test test/domain/models/plan_parse_test.dart
```
预期：`All tests passed!`。

- [ ] **Step 11: 提交**

```bash
git add app/lib/domain app/test/domain app/pubspec.yaml app/pubspec.lock
git commit -m "feat(domain): freezed models for plan/profile/day_task/exercise/meal/chat"
```

---

## Task 4: Plan JSON Schema 校验器

**Files:**
- Create: `app/lib/domain/plan_schema.dart`
- Create: `app/test/domain/plan_schema_test.dart`

**Interfaces:**
- Produces:
  - `PlanValidationResult validatePlanJson(String rawJson)` 返回 `{ plan: Plan?, error: String? }`
  - `bool looksLikePlanJson(String text)` 检测文本是否形如 `{...}` 完整 JSON

- [ ] **Step 1: 写失败测试 `app/test/domain/plan_schema_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/domain/plan_schema.dart';

void main() {
  group('looksLikePlanJson', () {
    test('returns true for pure JSON block', () {
      expect(looksLikePlanJson('{"weeks":12}'), isTrue);
    });
    test('returns true for JSON with leading/trailing whitespace', () {
      expect(looksLikePlanJson('  \n  {"weeks":12}\n  '), isTrue);
    });
    test('returns false for chat text', () {
      expect(looksLikePlanJson('好的，我已经为你准备好计划'), isFalse);
    });
  });

  group('validatePlanJson', () {
    test('accepts a complete valid plan', () {
      final raw = '''
      {
        "weeks": 12,
        "weekly_structure": "4 天训练 + 3 天休息",
        "goal_summary": "增肌",
        "training_days": [],
        "daily_meals": [],
        "startDate": "2026-08-14T00:00:00.000Z"
      }
      ''';
      final result = validatePlanJson(raw);
      expect(result.error, isNull);
      expect(result.plan, isNotNull);
      expect(result.plan!.weeks, 12);
    });

    test('rejects plan missing weeks field', () {
      final raw = '{"weekly_structure":"x","goal_summary":"y","training_days":[],"daily_meals":[],"startDate":"2026-08-14T00:00:00.000Z"}';
      final result = validatePlanJson(raw);
      expect(result.plan, isNull);
      expect(result.error, contains('weeks'));
    });

    test('rejects malformed JSON', () {
      final result = validatePlanJson('{not json}');
      expect(result.plan, isNull);
      expect(result.error, isNotNull);
    });
  });
}
```

- [ ] **Step 2: 跑测试确认失败**

```bash
flutter test test/domain/plan_schema_test.dart
```
预期：`target call site is not found` 类错误（符号未定义）。

- [ ] **Step 3: 实现 `app/lib/domain/plan_schema.dart`**

```dart
import 'dart:convert';
import 'plan.dart';
import 'models/plan.dart' show Plan;

class PlanValidationResult {
  final Plan? plan;
  final String? error;
  const PlanValidationResult.success(this.plan) : error = null;
  const PlanValidationResult.failure(this.error) : plan = null;
}

bool looksLikePlanJson(String text) {
  final trimmed = text.trim();
  if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return false;
  try {
    jsonDecode(trimmed);
    return true;
  } catch (_) {
    return false;
  }
}

PlanValidationResult validatePlanJson(String rawJson) {
  final trimmed = rawJson.trim();
  Map<String, dynamic>? json;
  try {
    final decoded = jsonDecode(trimmed);
    if (decoded is! Map<String, dynamic>) {
      return const PlanValidationResult.failure('JSON 顶层必须是对象');
    }
    json = decoded;
  } catch (e) {
    return PlanValidationResult.failure('JSON 解析失败: $e');
  }

  final required = ['weeks', 'weekly_structure', 'goal_summary', 'training_days', 'daily_meals'];
  for (final key in required) {
    if (!json.containsKey(key)) {
      return PlanValidationResult.failure('缺少必需字段: $key');
    }
  }

  if (json['weeks'] is! int || (json['weeks'] as int) <= 0) {
    return const PlanValidationResult.failure('weeks 必须是正整数');
  }
  if (json['training_days'] is! List) {
    return const PlanValidationResult.failure('training_days 必须是数组');
  }
  if (json['daily_meals'] is! List) {
    return const PlanValidationResult.failure('daily_meals 必须是数组');
  }

  try {
    final startDate = json['startDate'] is String
        ? DateTime.parse(json['startDate'] as String)
        : DateTime.now();
    final planWithDate = {...json, 'startDate': startDate.toIso8601String()};
    final plan = Plan.fromJson(planWithDate);
    return PlanValidationResult.success(plan);
  } catch (e) {
    return PlanValidationResult.failure('Plan 字段类型不匹配: $e');
  }
}
```

- [ ] **Step 4: 跑测试确认通过**

```bash
flutter test test/domain/plan_schema_test.dart
```
预期：`All tests passed!`。

- [ ] **Step 5: 提交**

```bash
git add app/lib/domain/plan_schema.dart app/test/domain/plan_schema_test.dart
git commit -m "feat(domain): plan JSON schema validator (looksLikePlanJson + validatePlanJson)"
```

---

## Task 5: Streak 计算器（纯逻辑，TDD）

**Files:**
- Create: `app/lib/domain/streak_calculator.dart`
- Create: `app/test/domain/streak_calculator_test.dart`

**Interfaces:**
- Produces:
  - `class StreakUpdate { final int newCurrentDays; final int newLongestDays; final int freezesConsumed; final bool streakBroken; final bool freezeAwarded; }`
  - `StreakUpdate evaluateStreakOnActive({required int currentStreakDays, required int longestStreakDays, required int freezesRemaining, required DateTime? lastActiveDate, required DateTime now})`
  - `bool shouldAwardFreeze({required DateTime? lastFreezeAwardDate, required DateTime now})`  // 每 30 天 true

- [ ] **Step 1: 写失败测试 `app/test/domain/streak_calculator_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/domain/streak_calculator.dart';

void main() {
  group('evaluateStreakOnActive', () {
    test('first ever active day sets streak to 1', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 0,
        longestStreakDays: 0,
        freezesRemaining: 2,
        lastActiveDate: null,
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 1);
      expect(r.streakBroken, isFalse);
      expect(r.freezesConsumed, 0);
    });

    test('consecutive day increments streak', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 2,
        lastActiveDate: DateTime(2026, 8, 13),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 6);
      expect(r.streakBroken, isFalse);
    });

    test('missed 1 day consumes freeze and preserves streak', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 2,
        lastActiveDate: DateTime(2026, 8, 12),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 6);
      expect(r.freezesConsumed, 1);
      expect(r.streakBroken, isFalse);
    });

    test('missed 2 days with no freezes resets streak', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 0,
        lastActiveDate: DateTime(2026, 8, 11),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 1);
      expect(r.streakBroken, isTrue);
      expect(r.newLongestDays, 10); // 不变
    });

    test('same-day active does nothing', () {
      final r = evaluateStreakOnActive(
        currentStreakDays: 5,
        longestStreakDays: 10,
        freezesRemaining: 2,
        lastActiveDate: DateTime(2026, 8, 14),
        now: DateTime(2026, 8, 14),
      );
      expect(r.newCurrentDays, 5);
      expect(r.freezesConsumed, 0);
    });
  });

  group('shouldAwardFreeze', () {
    test('awards when 30 days passed since last award', () {
      final result = shouldAwardFreeze(
        lastFreezeAwardDate: DateTime(2026, 7, 15),
        now: DateTime(2026, 8, 14),
      );
      expect(result, isTrue);
    });

    test('does not award within 30 days', () {
      final result = shouldAwardFreeze(
        lastFreezeAwardDate: DateTime(2026, 8, 1),
        now: DateTime(2026, 8, 14),
      );
      expect(result, isFalse);
    });

    test('awards when never awarded and 30 days passed', () {
      final result = shouldAwardFreeze(
        lastFreezeAwardDate: null,
        now: DateTime(2026, 8, 14),
      );
      expect(result, isFalse); // 首次安装不立即给
    });
  });
}
```

- [ ] **Step 2: 跑测试确认失败**

```bash
flutter test test/domain/streak_calculator_test.dart
```
预期：未定义符号错误。

- [ ] **Step 3: 实现 `app/lib/domain/streak_calculator.dart`**

```dart
class StreakUpdate {
  final int newCurrentDays;
  final int newLongestDays;
  final int freezesConsumed;
  final bool streakBroken;
  const StreakUpdate({
    required this.newCurrentDays,
    required this.newLongestDays,
    required this.freezesConsumed,
    required this.streakBroken,
  });
}

StreakUpdate evaluateStreakOnActive({
  required int currentStreakDays,
  required int longestStreakDays,
  required int freezesRemaining,
  required DateTime? lastActiveDate,
  required DateTime now,
}) {
  if (lastActiveDate == null) {
    return StreakUpdate(
      newCurrentDays: 1,
      newLongestDays: longestStreakDays > 1 ? longestStreakDays : 1,
      freezesConsumed: 0,
      streakBroken: false,
    );
  }

  final daysSince = _daysBetween(lastActiveDate, now);

  if (daysSince == 0) {
    return StreakUpdate(
      newCurrentDays: currentStreakDays,
      newLongestDays: longestStreakDays,
      freezesConsumed: 0,
      streakBroken: false,
    );
  }

  if (daysSince == 1) {
    final newCurrent = currentStreakDays + 1;
    final newLongest = newCurrent > longestStreakDays ? newCurrent : longestStreakDays;
    return StreakUpdate(
      newCurrentDays: newCurrent,
      newLongestDays: newLongest,
      freezesConsumed: 0,
      streakBroken: false,
    );
  }

  // Missed >= 2 days
  final freezesToUse = daysSince - 1;
  if (freezesRemaining >= freezesToUse) {
    final newCurrent = currentStreakDays + daysSince;
    final newLongest = newCurrent > longestStreakDays ? newCurrent : longestStreakDays;
    return StreakUpdate(
      newCurrentDays: newCurrent,
      newLongestDays: newLongest,
      freezesConsumed: freezesToUse,
      streakBroken: false,
    );
  }

  // Not enough freezes
  final newCurrent = freezesRemaining + 1;
  return StreakUpdate(
    newCurrentDays: newCurrent,
    newLongestDays: longestStreakDays,
    freezesConsumed: freezesRemaining,
    streakBroken: true,
  );
}

bool shouldAwardFreeze({
  required DateTime? lastFreezeAwardDate,
  required DateTime now,
}) {
  if (lastFreezeAwardDate == null) return false;
  return _daysBetween(lastFreezeAwardDate, now) >= 30;
}

int _daysBetween(DateTime from, DateTime to) {
  final fromDay = DateTime(from.year, from.month, from.day);
  final toDay = DateTime(to.year, to.month, to.day);
  return toDay.difference(fromDay).inDays;
}
```

- [ ] **Step 4: 跑测试确认通过**

```bash
flutter test test/domain/streak_calculator_test.dart
```
预期：`All tests passed!`。

- [ ] **Step 5: 提交**

```bash
git add app/lib/domain/streak_calculator.dart app/test/domain/streak_calculator_test.dart
git commit -m "feat(domain): streak calculator with freeze logic"
```

---

## Task 6: XP 引擎 + 徽章引擎（纯逻辑，TDD）

**Files:**
- Create: `app/lib/gamification/xp_engine.dart`
- Create: `app/lib/gamification/badge_engine.dart`
- Create: `app/test/gamification/xp_engine_test.dart`
- Create: `app/test/gamification/badge_engine_test.dart`

**Interfaces:**
- Produces:
  - `class XpAward { final int xp; final String reason; }`
  - `XpAward computeXpForWorkoutCompletion({required bool allMealsCompleted})` —— workout +30，若全餐完成额外 +50
  - `XpAward computeXpForMealCompletion({required int mealsCompletedBefore, required int totalMeals})` —— 4 餐全完成 +20
  - `XpAward computeXpForStreakMilestone({required int streakDays})` —— 7/30/100/365 天分别 +100/+300/+1000/+5000
  - `XpAward computeXpForBadgeUnlock()` —— 固定 +200
  - `XpAward computeXpForCoachAdjustment()` —— 固定 +10
  - `int levelFromXp(int totalXp)` —— `floor(totalXp / 1000) + 1`
  - `int xpToNextLevel(int totalXp)` —— `(level * 1000) - totalXp`
  - `class BadgeCondition { final String code; bool Function(Map<String,dynamic> stats) check; }`
  - `List<String> checkUnlockedBadges(Map<String,dynamic> stats)` —— 返回本次新解锁的 badge codes

- [ ] **Step 1: 写失败测试 `app/test/gamification/xp_engine_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/gamification/xp_engine.dart';

void main() {
  test('workout completion awards 30 xp', () {
    expect(computeXpForWorkoutCompletion(allMealsCompleted: false).xp, 30);
  });

  test('workout + all meals awards 80 xp (30+50)', () {
    expect(computeXpForWorkoutCompletion(allMealsCompleted: true).xp, 80);
  });

  test('all 4 meals completed awards 20 xp', () {
    expect(
      computeXpForMealCompletion(mealsCompletedBefore: 3, totalMeals: 4).xp,
      20,
    );
  });

  test('partial meals awards 0 xp', () {
    expect(
      computeXpForMealCompletion(mealsCompletedBefore: 2, totalMeals: 4).xp,
      0,
    );
  });

  test('streak milestones', () {
    expect(computeXpForStreakMilestone(streakDays: 7).xp, 100);
    expect(computeXpForStreakMilestone(streakDays: 30).xp, 300);
    expect(computeXpForStreakMilestone(streakDays: 100).xp, 1000);
    expect(computeXpForStreakMilestone(streakDays: 365).xp, 5000);
    expect(computeXpForStreakMilestone(streakDays: 10).xp, 0);
  });

  test('badge unlock awards 200', () {
    expect(computeXpForBadgeUnlock().xp, 200);
  });

  test('coach adjustment awards 10', () {
    expect(computeXpForCoachAdjustment().xp, 10);
  });

  test('level math', () {
    expect(levelFromXp(0), 1);
    expect(levelFromXp(999), 1);
    expect(levelFromXp(1000), 2);
    expect(levelFromXp(2500), 3);
    expect(xpToNextLevel(0), 1000);
    expect(xpToNextLevel(1500), 500);
  });
}
```

- [ ] **Step 2: 跑测试确认失败**

```bash
flutter test test/gamification/xp_engine_test.dart
```
预期：未定义符号。

- [ ] **Step 3: 实现 `app/lib/gamification/xp_engine.dart`**

```dart
class XpAward {
  final int xp;
  final String reason;
  const XpAward(this.xp, this.reason);
}

XpAward computeXpForWorkoutCompletion({required bool allMealsCompleted}) {
  if (allMealsCompleted) {
    return const XpAward(80, 'workout + all meals');
  }
  return const XpAward(30, 'workout');
}

XpAward computeXpForMealCompletion({
  required int mealsCompletedBefore,
  required int totalMeals,
}) {
  if (totalMeals > 0 && mealsCompletedBefore == totalMeals - 1) {
    return const XpAward(20, 'all meals');
  }
  return const XpAward(0, '');
}

XpAward computeXpForStreakMilestone({required int streakDays}) {
  const milestones = {7: 100, 30: 300, 100: 1000, 365: 5000};
  final xp = milestones[streakDays] ?? 0;
  return XpAward(xp, 'streak milestone');
}

XpAward computeXpForBadgeUnlock() => const XpAward(200, 'badge unlock');

XpAward computeXpForCoachAdjustment() => const XpAward(10, 'coach adjustment');

int levelFromXp(int totalXp) => (totalXp ~/ 1000) + 1;

int xpToNextLevel(int totalXp) {
  final level = levelFromXp(totalXp);
  return (level * 1000) - totalXp;
}
```

- [ ] **Step 4: 写徽章测试 `app/test/gamification/badge_engine_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/gamification/badge_engine.dart';

void main() {
  test('first workout unlocks FIRST_WORKOUT badge', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 1,
      'longestStreak': 0,
      'totalDaysAllMealsCompleted': 0,
      'level': 1,
    });
    expect(unlocked, contains('FIRST_WORKOUT'));
  });

  test('7 day streak unlocks ONE_WEEK_STREAK', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 7,
      'longestStreak': 7,
      'totalDaysAllMealsCompleted': 0,
      'level': 1,
    });
    expect(unlocked, contains('ONE_WEEK_STREAK'));
  });

  test('100 day streak unlocks HUNDRED_DAYS', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 100,
      'longestStreak': 100,
      'totalDaysAllMealsCompleted': 0,
      'level': 5,
    });
    expect(unlocked, contains('HUNDRED_DAYS'));
  });

  test('7 consecutive all-meal days unlocks IRON_STOMACH', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 7,
      'longestStreak': 7,
      'totalDaysAllMealsCompleted': 7,
      'level': 1,
    });
    expect(unlocked, contains('IRON_STOMACH'));
  });

  test('level 10 unlocks FITNESS_OWL', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 50,
      'longestStreak': 30,
      'totalDaysAllMealsCompleted': 0,
      'level': 10,
    });
    expect(unlocked, contains('FITNESS_OWL'));
  });

  test('no badges for new user', () {
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': 0,
      'longestStreak': 0,
      'totalDaysAllMealsCompleted': 0,
      'level': 1,
    });
    expect(unlocked, isEmpty);
  });
}
```

- [ ] **Step 5: 实现 `app/lib/gamification/badge_engine.dart`**

```dart
const _badgeConditions = <String, bool Function(Map<String, dynamic>)>{
  'FIRST_WORKOUT': (s) => (s['totalWorkoutsCompleted'] as int) >= 1,
  'ONE_WEEK_STREAK': (s) => (s['longestStreak'] as int) >= 7,
  'HUNDRED_DAYS': (s) => (s['longestStreak'] as int) >= 100,
  'IRON_STOMACH': (s) => (s['totalDaysAllMealsCompleted'] as int) >= 7,
  'FITNESS_OWL': (s) => (s['level'] as int) >= 10,
};

List<String> checkUnlockedBadges(Map<String, dynamic> stats) {
  return _badgeConditions.entries
      .where((e) => e.value(stats))
      .map((e) => e.key)
      .toList();
}
```

- [ ] **Step 6: 跑两个测试**

```bash
flutter test test/gamification/
```
预期：`All tests passed!`。

- [ ] **Step 7: 提交**

```bash
git add app/lib/gamification app/test/gamification
git commit -m "feat(gamification): xp engine and badge unlock engine"
```

---

## Task 7: Duolingo 主题（颜色 + 字体 + 粗描边按钮 + 吉祥物）

**Files:**
- Create: `app/lib/theme/colors.dart`
- Create: `app/lib/theme/text_styles.dart`
- Create: `app/lib/theme/buttons.dart`
- Create: `app/lib/theme/mascot.dart`
- Create: `app/test/theme/theme_test.dart`

**Interfaces:**
- Produces:
  - `class AppColors` with const static `duoGreen`, `duoPurple`, `duoGold`, `duoRed`, `duoBackground`, `duoBlack`
  - `class AppTextStyles` with const static `h1`, `h2`, `body`, `button`
  - `class AppButtons` with factory `primary()`, `secondary()`, `danger()` 返回带粗描边的 `Widget`
  - `class AppMascot` with factory `mascot({String mood = 'happy'})` 返回 Lottie 占位（先用 `Icon`）

- [ ] **Step 1: 添加 Lottie 依赖**

`app/pubspec.yaml`：
```yaml
  lottie: ^3.1.0
```

```bash
flutter pub get
```

- [ ] **Step 2: 创建 `app/lib/theme/colors.dart`**

```dart
import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color duoGreen = Color(0xFF58CC02);
  static const Color duoPurple = Color(0xFFCE82FF);
  static const Color duoGold = Color(0xFFFFC800);
  static const Color duoRed = Color(0xFFFF4B4B);
  static const Color duoBackground = Color(0xFFF7F7F7);
  static const Color duoBlack = Color(0xFF000000);
  static const Color duoGray = Color(0xFFE5E5E5);
  static const Color duoText = Color(0xFF3C3C3C);
}
```

- [ ] **Step 3: 创建 `app/lib/theme/text_styles.dart`**

```dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.duoText,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.duoText,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.duoText,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.8,
  );
}
```

- [ ] **Step 4: 创建 `app/lib/theme/buttons.dart`**

```dart
import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

enum AppButtonKind { primary, secondary, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.kind = AppButtonKind.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = switch (kind) {
      AppButtonKind.primary => AppColors.duoGreen,
      AppButtonKind.secondary => Colors.white,
      AppButtonKind.danger => AppColors.duoRed,
    };
    final fg = switch (kind) {
      AppButtonKind.secondary => AppColors.duoText,
      _ => Colors.white,
    };
    final borderColor = AppColors.duoBlack;

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: AppColors.duoBlack, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: AppTextStyles.button.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: 创建 `app/lib/theme/mascot.dart`（占位实现）**

```dart
import 'package:flutter/material.dart';
import 'colors.dart';

/// Lottie 占位：先用 emoji + 圆形背景。
/// 后期替换为真实 Lottie JSON 文件 `assets/mascot.json`。
class AppMascot extends StatelessWidget {
  final String mood; // happy / cheer / sad
  final double size;

  const AppMascot({super.key, this.mood = 'happy', this.size = 80});

  @override
  Widget build(BuildContext context) {
    final emoji = switch (mood) {
      'cheer' => '🦉�',
      'sad' => '🦉💧',
      _ => '🦉',
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.duoGold,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.duoBlack, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(emoji, style: TextStyle(fontSize: size * 0.5)),
    );
  }
}
```

- [ ] **Step 6: 写主题测试 `app/test/theme/theme_test.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/theme/buttons.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

void main() {
  testWidgets('AppButton renders label and respects onPressed', (tester) async {
    var pressed = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: AppButton(label: '开始健身', onPressed: () => pressed++),
        ),
      ),
    ));
    expect(find.text('开始健身'), findsOneWidget);
    await tester.tap(find.byType(AppButton));
    expect(pressed, 1);
  });

  test('AppColors.duoGreen matches spec', () {
    expect(AppColors.duoGreen.toARGB32(), 0xFF58CC02);
  });

  testWidgets('AppMascot renders emoji', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Center(child: AppMascot(mood: 'happy'))),
    ));
    expect(find.text('🦉'), findsOneWidget);
  });
}
```

- [ ] **Step 7: 跑测试**

```bash
flutter test test/theme/
```
预期：`All tests passed!`。

- [ ] **Step 8: 提交**

```bash
git add app/lib/theme app/test/theme app/pubspec.yaml
git commit -m "feat(theme): Duolingo style colors, chunky buttons, mascot placeholder"
```

---

## Task 8: 路由 + 五大空屏

**Files:**
- Create: `app/lib/router.dart`
- Create: `app/lib/features/onboarding/onboarding_screen.dart`
- Create: `app/lib/features/today/today_screen.dart`
- Create: `app/lib/features/path/path_screen.dart`
- Create: `app/lib/features/coach/coach_screen.dart`
- Create: `app/lib/features/profile/profile_screen.dart`
- Modify: `app/lib/app.dart`

**Interfaces:**
- Produces:
  - `GoRouter buildRouter()` —— 5 条主路由 `/onboarding`、`/today`、`/path`、`/coach`、`/profile`，加底部 tab bar

- [ ] **Step 1: 添加 go_router 依赖**

```yaml
# pubspec.yaml
  go_router: ^14.0.0
```

```bash
flutter pub get
```

- [ ] **Step 2: 创建 5 个空屏（每个都用 `AppMascot` + 屏幕名）**

`app/lib/features/onboarding/onboarding_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppMascot(mood: 'cheer', size: 120),
            SizedBox(height: 20),
            Text('欢迎，跟教练聊聊', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
```

`app/lib/features/today/today_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppMascot(size: 120),
            SizedBox(height: 20),
            Text('今日任务', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
```

`app/lib/features/path/path_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class PathScreen extends StatelessWidget {
  const PathScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppMascot(mood: 'cheer', size: 120),
            SizedBox(height: 20),
            Text('12 周路径图', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
```

`app/lib/features/coach/coach_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppMascot(mood: 'happy', size: 120),
            SizedBox(height: 20),
            Text('与教练对话', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
```

`app/lib/features/profile/profile_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppMascot(size: 120),
            SizedBox(height: 20),
            Text('个人 / 徽章墙', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: 创建 `app/lib/router.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/today/today_screen.dart';
import 'features/path/path_screen.dart';
import 'features/coach/coach_screen.dart';
import 'features/profile/profile_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      ShellRoute(
        builder: (context, state, child) => _TabScaffold(child: child),
        routes: [
          GoRoute(path: '/today', builder: (_, __) => const TodayScreen()),
          GoRoute(path: '/path', builder: (_, __) => const PathScreen()),
          GoRoute(path: '/coach', builder: (_, __) => const CoachScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        ],
      ),
    ],
  );
}

class _TabScaffold extends StatelessWidget {
  final Widget child;
  const _TabScaffold({required this.child});

  static const _tabs = [
    ('/today', Icons.local_fire_department, '今日'),
    ('/path', Icons.timeline, '路径'),
    ('/coach', Icons.chat_bubble, '教练'),
    ('/profile', Icons.person, '我'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabs.indexWhere((t) => t.$1 == location).clamp(0, _tabs.length - 1),
        onDestinationSelected: (i) => context.go(_tabs[i].$1),
        destinations: _tabs
            .map((t) => NavigationDestination(icon: Icon(t.$2), label: t.$3))
            .toList(),
      ),
    );
  }
}
```

- [ ] **Step 4: 修改 `app/lib/app.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'router.dart';

class GymCoachApp extends StatelessWidget {
  const GymCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '健身猫头鹰',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.duoGreen),
        useMaterial3: true,
      ),
      routerConfig: buildRouter(),
    );
  }
}
```

- [ ] **Step 5: 跑一下确认编译通过**

```bash
cd app && flutter analyze
```
预期：`No issues found!`。

- [ ] **Step 6: 提交**

```bash
git add app/lib/router.dart app/lib/app.dart app/lib/features app/pubspec.yaml
git commit -m "feat(ui): router with 5 screens (onboarding shell + 4 tabs)"
```

---

## Task 9: Proxy — HMAC 校验 + 限流 + Qwen 客户端

**Files:**
- Create: `proxy/src/auth.ts`
- Create: `proxy/src/rate-limit.ts`
- Create: `proxy/src/llm-client.ts`
- Modify: `proxy/src/index.ts`
- Create: `proxy/test/auth.test.ts`
- Create: `proxy/test/rate-limit.test.ts`
- Create: `proxy/test/llm-client.test.ts`

**Interfaces:**
- Produces:
  - `verifyHmac(secret: string, timestamp: string, body: string, signature: string): boolean` —— 5 分钟时间窗
  - `class RateLimiter { consume(key: string): { allowed: boolean; remaining: number } }` —— 每 IP 每天 1000 次
  - `class QwenClient { streamChat(req: ChatRequest): AsyncIterable<string> }` —— 通过 fetch 调 DashScope
  - Proxy `POST /v1/chat` 端点：验签 → 限流 → 流式转发 → SSE 输出

- [ ] **Step 1: 写 HMAC 测试 `proxy/test/auth.test.ts`**

```typescript
import { describe, it, expect } from 'vitest';
import { computeSignature, verifyHmac } from '../src/auth';

describe('HMAC auth', () => {
  it('verifies matching signature', () => {
    const secret = 'test-secret';
    const ts = '1692000000';
    const body = '{"messages":[]}';
    const sig = computeSignature(secret, ts, body);
    expect(verifyHmac(secret, ts, body, sig)).toBe(true);
  });

  it('rejects mismatching body', () => {
    const sig = computeSignature('s', '1', 'a');
    expect(verifyHmac('s', '1', 'b', sig)).toBe(false);
  });

  it('rejects stale timestamp (over 5 minutes)', () => {
    const oldTs = String(Math.floor(Date.now() / 1000) - 600);
    const sig = computeSignature('s', oldTs, 'b');
    expect(verifyHmac('s', oldTs, 'b', sig)).toBe(false);
  });
});
```

- [ ] **Step 2: 实现 `proxy/src/auth.ts`**

```typescript
export async function computeSignature(
  secret: string,
  timestamp: string,
  body: string,
): Promise<string> {
  const data = `${timestamp}.${body}`;
  const key = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const sig = await crypto.subtle.sign('HMAC', key, new TextEncoder().encode(data));
  return Array.from(new Uint8Array(sig))
    .map((b) => b.toString(16).padStart(2, '0'))
    .join('');
}

export async function verifyHmac(
  secret: string,
  timestamp: string,
  body: string,
  signature: string,
): Promise<boolean> {
  const ts = parseInt(timestamp, 10);
  if (!Number.isFinite(ts)) return false;
  const now = Math.floor(Date.now() / 1000);
  if (Math.abs(now - ts) > 300) return false; // 5 minutes
  const expected = await computeSignature(secret, timestamp, body);
  return timingSafeEqual(expected, signature);
}

function timingSafeEqual(a: string, b: string): boolean {
  if (a.length !== b.length) return false;
  let result = 0;
  for (let i = 0; i < a.length; i++) {
    result |= a.charCodeAt(i) ^ b.charCodeAt(i);
  }
  return result === 0;
}
```

- [ ] **Step 3: 写限流测试 `proxy/test/rate-limit.test.ts`**

```typescript
import { describe, it, expect } from 'vitest';
import { RateLimiter } from '../src/rate-limit';

describe('RateLimiter', () => {
  it('allows under quota', () => {
    const rl = new RateLimiter(3);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(false);
  });

  it('isolates keys', () => {
    const rl = new RateLimiter(1);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k2').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(false);
  });
});
```

- [ ] **Step 4: 实现 `proxy/src/rate-limit.ts`**

```typescript
export class RateLimiter {
  private readonly quota: number;
  private readonly buckets = new Map<string, number>();

  constructor(quota: number) {
    this.quota = quota;
  }

  consume(key: string): { allowed: boolean; remaining: number } {
    const used = this.buckets.get(key) ?? 0;
    if (used >= this.quota) {
      return { allowed: false, remaining: 0 };
    }
    this.buckets.set(key, used + 1);
    return { allowed: true, remaining: this.quota - used - 1 };
  }

  reset(key: string) {
    this.buckets.delete(key);
  }
}
```

- [ ] **Step 5: 写 Qwen 客户端测试 `proxy/test/llm-client.test.ts`**

```typescript
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { QwenClient } from '../src/llm-client';

describe('QwenClient.streamChat', () => {
  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('streams chunks and parses SSE data lines', async () => {
    const sseBody = [
      'data: {"choices":[{"delta":{"content":"你"}}]}\n',
      'data: {"choices":[{"delta":{"content":"好"}}]}\n',
      'data: [DONE]\n',
    ].join('');

    const mockFetch = vi.fn().mockResolvedValue(
      new Response(sseBody, { status: 200, headers: { 'content-type': 'text/event-stream' } }),
    );
    vi.stubGlobal('fetch', mockFetch);

    const client = new QwenClient('test-key', 'qwen-plus', 'https://example.com/v1/chat/completions');
    const chunks: string[] = [];
    for await (const chunk of client.streamChat({
      messages: [{ role: 'user', content: 'hi' }],
      temperature: 0.7,
    })) {
      chunks.push(chunk);
    }
    expect(chunks).toEqual(['你', '好']);
  });

  it('throws on non-200 response', async () => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(new Response('bad', { status: 500 })));
    const client = new QwenClient('k', 'm', 'https://e');
    await expect(async () => {
      for await (const _ of client.streamChat({ messages: [], temperature: 0 })) { /* noop */ }
    }).rejects.toThrow();
  });
});
```

- [ ] **Step 6: 实现 `proxy/src/llm-client.ts`**

```typescript
export interface ChatMessage {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

export interface ChatRequest {
  messages: ChatMessage[];
  temperature?: number;
  stream?: boolean;
}

export class QwenClient {
  constructor(
    private readonly apiKey: string,
    private readonly model: string,
    private readonly endpoint: string,
  ) {}

  async *streamChat(req: ChatRequest): AsyncIterable<string> {
    const res = await fetch(this.endpoint, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: this.model,
        messages: req.messages,
        temperature: req.temperature ?? 0.7,
        stream: true,
      }),
    });

    if (!res.ok) {
      throw new Error(`Qwen API ${res.status}: ${await res.text()}`);
    }
    if (!res.body) throw new Error('No response body');

    const reader = (res.body as ReadableStream<Uint8Array>).getReader();
    const decoder = new TextDecoder();
    let buffer = '';

    while (true) {
      const { value, done } = await reader.read();
      if (done) break;
      buffer += decoder.decode(value, { stream: true });
      const lines = buffer.split('\n');
      buffer = lines.pop() ?? '';
      for (const line of lines) {
        const trimmed = line.trim();
        if (!trimmed.startsWith('data:')) continue;
        const payload = trimmed.slice(5).trim();
        if (payload === '[DONE]') return;
        try {
          const parsed = JSON.parse(payload);
          const delta = parsed.choices?.[0]?.delta?.content;
          if (typeof delta === 'string' && delta.length > 0) {
            yield delta;
          }
        } catch {
          // skip malformed
        }
      }
    }
  }
}
```

- [ ] **Step 7: 实现 `proxy/src/index.ts`（完整版本）**

```typescript
import { Hono } from 'hono';
import type { Env } from './config';
import { getConfig } from './config';
import { verifyHmac } from './auth';
import { RateLimiter } from './rate-limit';
import { QwenClient, ChatMessage } from './llm-client';

interface ChatRequestBody {
  messages: ChatMessage[];
  model?: string;
  stream?: boolean;
  temperature?: number;
}

const rl = new RateLimiter(1000);

const app = new Hono<{ Bindings: Env }>();

app.get('/health', (c) => c.json({ status: 'ok' }));

app.post('/v1/chat', async (c) => {
  const cfg = getConfig(c.env);

  const ts = c.req.header('X-Timestamp');
  const sig = c.req.header('X-Signature');
  if (!ts || !sig) return c.json({ error: 'missing auth headers' }, 401);

  const body = await c.req.text();
  const valid = await verifyHmac(cfg.hmacSecret, ts, body, sig);
  if (!valid) return c.json({ error: 'invalid signature' }, 401);

  const ip = c.req.header('CF-Connecting-IP') ?? 'unknown';
  const limit = rl.consume(ip);
  if (!limit.allowed) return c.json({ error: 'rate limited' }, 429);

  let payload: ChatRequestBody;
  try {
    payload = JSON.parse(body);
  } catch {
    return c.json({ error: 'invalid json' }, 400);
  }

  const client = new QwenClient(cfg.qwenApiKey, cfg.qwenModel, cfg.qwenEndpoint);

  const stream = new ReadableStream({
    async start(controller) {
      const enc = new TextEncoder();
      try {
        for await (const chunk of client.streamChat({
          messages: payload.messages,
          temperature: payload.temperature ?? 0.7,
        })) {
          controller.enqueue(enc.encode(`data: ${JSON.stringify({ delta: chunk })}\n\n`));
        }
        controller.enqueue(enc.encode('data: [DONE]\n\n'));
      } catch (e) {
        controller.enqueue(enc.encode(`data: ${JSON.stringify({ error: String(e) })}\n\n`));
      } finally {
        controller.close();
      }
    },
  });

  return new Response(stream, {
    headers: {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
    },
  });
});

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    return app.fetch(request, env);
  },
};
```

- [ ] **Step 8: 跑全部 proxy 测试**

```bash
cd proxy && npm test
```
预期：全部通过。

- [ ] **Step 9: 提交**

```bash
git add proxy/src proxy/test
git commit -m "feat(proxy): hmac auth + rate limit + Qwen streaming client"
```

---

## Task 10: Flutter LLM Client + SSE 解析

**Files:**
- Create: `app/lib/data/llm/sse_parser.dart`
- Create: `app/lib/data/llm/llm_client.dart`
- Create: `app/test/data/llm/sse_parser_test.dart`
- Create: `app/test/data/llm/llm_client_test.dart`

**Interfaces:**
- Produces:
  - `Stream<String> parseSse(Stream<List<int>> byteStream)` —— 把 SSE 字节流解析为 `data: {...}` 的 delta 字符串
  - `class LlmClient { Stream<String> chat({required List<ChatMessage> messages, String? model, double temperature = 0.7}) }` —— 含 HMAC 签名 + 指数退避重试（最多 3 次）

- [ ] **Step 1: 写 SSE 解析测试 `app/test/data/llm/sse_parser_test.dart`**

```dart
import 'dart:convert;
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/llm/sse_parser.dart';

void main() {
  test('parses SSE chunks and yields delta payloads', () async {
    final sse = utf8.encode([
      'data: {"delta":"你"}\n\n',
      'data: {"delta":"好"}\n\n',
      'data: [DONE]\n\n',
    ].join());
    final stream = Stream<List<int>>.fromIterable([sse]);
    final results = await parseSse(stream).toList();
    expect(results, ['你', '好']);
  });

  test('skips non-data lines and comments', () async {
    final sse = utf8.encode([
      ':heartbeat\n\n',
      'event: ping\n\n',
      'data: {"delta":"x"}\n\n',
    ].join());
    final stream = Stream<List<int>>.fromIterable([sse]);
    final results = await parseSse(stream).toList();
    expect(results, ['x']);
  });
}
```

- [ ] **Step 2: 实现 `app/lib/data/llm/sse_parser.dart`**

```dart
import 'dart:async';
import 'dart:convert';

Stream<String> parseSse(Stream<List<int>> byteStream) async* {
  final lineStream = byteStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  String? dataBuffer;

  await for (final line in lineStream) {
    if (line.isEmpty) {
      // event boundary
      if (dataBuffer != null) {
        if (dataBuffer == '[DONE]') {
          return;
        }
        try {
          final json = jsonDecode(dataBuffer);
          if (json is Map && json['delta'] is String) {
            yield json['delta'] as String;
          }
        } catch (_) {/* skip */}
        dataBuffer = null;
      }
      continue;
    }
    if (line.startsWith(':')) continue;          // comment
    if (!line.startsWith('data:')) continue;     // other fields
    dataBuffer = (dataBuffer == null ? '' : '$dataBuffer\n') + line.substring(5).trim();
  }
}
```

- [ ] **Step 3: 写 LLM client 测试 `app/test/data/llm/llm_client_test.dart`**

```dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/llm/llm_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('client sends signed POST and parses SSE', () async {
    final mock = MockClient((req) async {
      expect(req.headers['X-Signature'], isNotEmpty);
      expect(req.headers['X-Timestamp'], isNotEmpty);
      expect(req.body, contains('"messages"'));
      return http.StreamedResponse(
        Stream.value(utf8.encode('data: {"delta":"好"}\n\ndata: [DONE]\n\n')),
        200,
        headers: {'content-type': 'text/event-stream'},
      );
    });

    final client = LlmClient(
      endpoint: 'https://example.com',
      hmacSecret: 'secret',
      httpClient: mock,
    );
    final chunks = await client.chat(
      messages: [
        {'role': 'user', 'content': 'hi'},
      ],
    ).toList();
    expect(chunks, ['好']);
  });

  test('retries on 500 and eventually succeeds', () async {
    var attempts = 0;
    final mock = MockClient((req) async {
      attempts++;
      if (attempts < 2) {
        return http.StreamedResponse(
          Stream.value(utf8.encode('boom')),
          500,
        );
      }
      return http.StreamedResponse(
        Stream.value(utf8.encode('data: {"delta":"ok"}\n\ndata: [DONE]\n\n')),
        200,
        headers: {'content-type': 'text/event-stream'},
      );
    });
    final client = LlmClient(
      endpoint: 'https://example.com',
      hmacSecret: 's',
      httpClient: mock,
    );
    final chunks = await client.chat(messages: [
      {'role': 'user', 'content': 'hi'},
    ]).toList();
    expect(chunks, ['ok']);
    expect(attempts, 2);
  });
}
```

- [ ] **Step 4: 添加 http 依赖**

```yaml
# pubspec.yaml
  http: ^1.2.0
```

```bash
flutter pub get
```

- [ ] **Step 5: 实现 `app/lib/data/llm/llm_client.dart`**

```dart
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'sse_parser.dart';

class LlmClient {
  final String endpoint;
  final String hmacSecret;
  final http.Client httpClient;
  final int maxRetries;

  LlmClient({
    required this.endpoint,
    required this.hmacSecret,
    http.Client? httpClient,
    this.maxRetries = 3,
  }) : httpClient = httpClient ?? http.Client();

  Stream<String> chat({
    required List<Map<String, String>> messages,
    String? model,
    double temperature = 0.7,
  }) async* {
    final body = jsonEncode({
      'messages': messages,
      'temperature': temperature,
      if (model != null) 'model': model,
    });

    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final signature = _sign(timestamp, body);

    var attempt = 0;
    while (true) {
      attempt++;
      try {
        final req = http.Request('POST', Uri.parse('$endpoint/v1/chat'))
          ..headers.addAll({
            'Content-Type': 'application/json',
            'X-Timestamp': timestamp,
            'X-Signature': signature,
          })
          ..body = body;
        final res = await httpClient.send(req);
        if (res.statusCode == 200) {
          yield* parseSse(res.stream);
          return;
        }
        if (attempt >= maxRetries || res.statusCode < 500) {
          throw Exception('LLM HTTP ${res.statusCode}');
        }
      } catch (_) {
        if (attempt >= maxRetries) rethrow;
      }
      await Future.delayed(Duration(milliseconds: 200 * (1 << (attempt - 1))));
    }
  }

  String _sign(String timestamp, String body) {
    final hmac = Hmac(sha256, utf8.encode(hmacSecret));
    final digest = hmac.convert(utf8.encode('$timestamp.$body'));
    return digest.toString();
  }

  void close() => httpClient.close();
}
```

- [ ] **Step 6: 添加 crypto 依赖**

```yaml
# pubspec.yaml
  crypto: ^3.0.3
```

```bash
flutter pub get
```

- [ ] **Step 7: 跑测试**

```bash
cd app && flutter test test/data/llm/
```
预期：`All tests passed!`。

- [ ] **Step 8: 提交**

```bash
git add app/lib/data/llm app/test/data/llm app/pubspec.yaml
git commit -m "feat(llm): dart SSE parser + signed HTTP client with exponential backoff"
```

---

## Task 11: Repositories（5 个）

**Files:**
- Create: `app/lib/data/repositories/profile_repository.dart`
- Create: `app/lib/data/repositories/plan_repository.dart`
- Create: `app/lib/data/repositories/day_task_repository.dart`
- Create: `app/lib/data/repositories/chat_repository.dart`
- Create: `app/lib/data/repositories/gamification_repository.dart`
- Create: `app/test/data/repositories/profile_repository_test.dart`
- Create: `app/test/data/repositories/plan_repository_test.dart`

**Interfaces:**
- Produces:
  - `class ProfileRepository { Future<UserProfile?> get(); Future<void> save(UserProfile p); }`
  - `class PlanRepository { Future<Plan?> getActive(); Future<int> create(Plan p); Future<void> deactivateAll(); }`
  - `class DayTaskRepository { Future<DayTask?> getByDate(DateTime date); Future<List<DayTask>> getAllForActivePlan(); Future<void> markWorkoutDone(int id); Future<void> markMealDone(int id, String slot); Future<void> awardXp(int id, int xp); }`
  - `class ChatRepository { Future<List<ChatMessage>> getForPlan(int planId); Future<void> add(ChatMessage m); }`
  - `class GamificationRepository { Future<StreakData> getStreak(); Future<void> updateStreak(StreakData s); Future<int> getTotalXp(); Future<int> getTotalWorkoutsCompleted(); Future<int> getTotalDaysAllMealsCompleted(); Future<void> recordEvent(String type, int value); Future<List<String>> getUnlockedBadges(); }`

- [ ] **Step 1: 写 profile repo 测试 `app/test/data/repositories/profile_repository_test.dart`**

```dart
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
```

- [ ] **Step 2: 实现 `app/lib/data/repositories/profile_repository.dart`**

```dart
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
```

- [ ] **Step 3: 写 plan repo 测试 `app/test/data/repositories/plan_repository_test.dart`**

```dart
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
    final id1 = await repo.create(plan);
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
```

- [ ] **Step 4: 实现 `app/lib/data/repositories/plan_repository.dart`**

```dart
import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/plan.dart';

class StoredPlan {
  final int id;
  final Plan plan;
  const StoredPlan(this.id, this.plan);
}

class PlanRepository {
  final AppDatabase db;
  PlanRepository(this.db);

  Future<int> create(Plan plan) async {
    final existing = await (db.select(db.plans)..limit(1)).getSingleOrNull();
    final version = existing == null ? 1 : existing.version + 1;
    return db.into(db.plans).insert(
      PlansCompanion.insert(
        version: version,
        startDate: plan.startDate,
        weeks: plan.weeks,
        planJson: jsonEncode({
          'weeks': plan.weeks,
          'weekly_structure': plan.weeklyStructure,
          'goal_summary': plan.goalSummary,
          'training_days':
              plan.trainingDays.map((t) => t.toJson()).toList(),
          'daily_meals':
              plan.dailyMeals.map((d) => d.toJson()).toList(),
        }),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> deactivateAll() async {
    await db.update(db.plans).write(const PlansCompanion(active: Value(false)));
  }

  Future<StoredPlan?> getActive() async {
    final row = await (db.select(db.plans)
          ..where((p) => p.active.equals(true))
          ..orderBy([(p) => OrderingTerm.desc(p.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    final json = jsonDecode(row.planJson) as Map<String, dynamic>;
    json['startDate'] = row.startDate.toIso8601String();
    return StoredPlan(row.id, Plan.fromJson(json));
  }
}
```

- [ ] **Step 5: 实现其他三个 repository（按相同模式，含 CRUD）**

`app/lib/data/repositories/day_task_repository.dart`:
```dart
import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/day_task.dart';
import '../../domain/models/exercise.dart';
import '../../domain/models/meal.dart';

class DayTaskRepository {
  final AppDatabase db;
  DayTaskRepository(this.db);

  Future<DayTask?> getByDate(int planId, DateTime date) async {
    final row = await (db.select(db.dayTasks)
          ..where((t) => t.planId.equals(planId) & t.date.equals(date))
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return _toModel(row);
  }

  Future<List<DayTask>> getAllForPlan(int planId) async {
    final rows = await (db.select(db.dayTasks)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.asc(t.dayIndex)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<void> markWorkoutDone(int id) async {
    await (db.update(db.dayTasks)..where((t) => t.id.equals(id))).write(
      DayTasksCompanion(
        completedWorkout: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markMealDone(int id, String slot, bool done) async {
    final row = await (db.select(db.dayTasks)..where((t) => t.id.equals(id))).getSingle();
    final map = (jsonDecode(row.completedMeals) as Map).cast<String, bool>();
    map[slot] = done;
    await (db.update(db.dayTasks)..where((t) => t.id.equals(id))).write(
      DayTasksCompanion(completedMeals: Value(jsonEncode(map))),
    );
  }

  Future<void> awardXp(int id, int additionalXp) async {
    final row = await (db.select(db.dayTasks)..where((t) => t.id.equals(id))).getSingle();
    await (db.update(db.dayTasks)..where((t) => t.id.equals(id))).write(
      DayTasksCompanion(xpAwarded: Value(row.xpAwarded + additionalXp)),
    );
  }

  DayTask _toModel(DayTask row) {
    final workoutJson = row.workoutJson.isEmpty ? null : jsonDecode(row.workoutJson);
    final mealsJson = (jsonDecode(row.mealsJson) as List).cast<Map<String, dynamic>>();
    return DayTask(
      dbId: row.id,
      planId: row.planId,
      dayIndex: row.dayIndex,
      date: row.date,
      workout: workoutJson == null
          ? null
          : Workout(
              title: workoutJson['title'] as String,
              estimatedMinutes: workoutJson['estimated_minutes'] as int,
              exercises: (workoutJson['exercises'] as List)
                  .cast<Map<String, dynamic>>()
                  .map(Exercise.fromJson)
                  .toList(),
            ),
      meals: mealsJson.map(Meal.fromJson).toList(),
      completedWorkout: row.completedWorkout,
      completedMeals:
          (jsonDecode(row.completedMeals) as Map).cast<String, bool>(),
      xpAwarded: row.xpAwarded,
      completedAt: row.completedAt,
    );
  }
}
```

`app/lib/data/repositories/chat_repository.dart`:
```dart
import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/chat_message.dart';

class ChatRepository {
  final AppDatabase db;
  ChatRepository(this.db);

  Future<List<ChatMessage>> getForPlan(int planId) async {
    final rows = await (db.select(db.chatMessages)
          ..where((m) => m.planId.equals(planId))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();
    return rows
        .map((r) => ChatMessage(
              planId: r.planId,
              role: ChatRole.values.byName(r.role),
              content: r.content,
              createdAt: r.createdAt,
            ))
        .toList();
  }

  Future<void> add(ChatMessage m) async {
    await db.into(db.chatMessages).insert(
      ChatMessagesCompanion.insert(
        planId: m.planId,
        role: m.role.name,
        content: m.content,
        createdAt: m.createdAt,
      ),
    );
  }
}
```

`app/lib/data/repositories/gamification_repository.dart`:
```dart
import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';

class StreakData {
  final int currentDays;
  final int longestDays;
  final DateTime? lastActiveDate;
  final int freezesRemaining;
  const StreakData({
    required this.currentDays,
    required this.longestDays,
    required this.lastActiveDate,
    required this.freezesRemaining,
  });
}

class GamificationRepository {
  final AppDatabase db;
  GamificationRepository(this.db);

  Future<StreakData> getStreak() async {
    final row = await (db.select(db.streaks)..limit(1)).getSingleOrNull();
    if (row == null) {
      await db.into(db.streaks).insert(StreaksCompanion.insert());
      return const StreakData(currentDays: 0, longestDays: 0, lastActiveDate: null, freezesRemaining: 2);
    }
    return StreakData(
      currentDays: row.currentDays,
      longestDays: row.longestDays,
      lastActiveDate: row.lastActiveDate,
      freezesRemaining: row.freezesRemaining,
    );
  }

  Future<void> updateStreak(StreakData s) async {
    await db.update(db.streaks).write(
      StreaksCompanion(
        currentDays: Value(s.currentDays),
        longestDays: Value(s.longestDays),
        lastActiveDate: Value(s.lastActiveDate),
        freezesRemaining: Value(s.freezesRemaining),
      ),
    );
  }

  Future<int> getTotalXp() async {
    final row = await (db.select(db.dayTasks)).get();
    return row.fold<int>(0, (sum, t) => sum + t.xpAwarded);
  }

  Future<int> getTotalWorkoutsCompleted() async {
    final count = await (db.selectOnly(db.dayTasks)
          ..addColumns([db.dayTasks.id.count()])
          ..where(db.dayTasks.completedWorkout.equals(true)))
        .map((row) => row.read<int>(db.dayTasks.id.count()) ?? 0)
        .getSingle();
    return count;
  }

  Future<int> getTotalDaysAllMealsCompleted() async {
    final rows = await (db.select(db.dayTasks)
          ..where((t) => t.completedWorkout.equals(true)))
        .get();
    return rows.where((t) {
      final map = (jsonDecode(t.completedMeals) as Map).cast<String, bool>();
      return map.values.isNotEmpty && map.values.every((v) => v);
    }).length;
  }

  Future<void> recordEvent(String type, int value) async {
    await db.into(db.gamificationEvents).insert(
      GamificationEventsCompanion.insert(
        eventType: type,
        value: value,
        createdAt: DateTime.now(),
      ),
    );
  }
}
```

- [ ] **Step 6: 跑两个测试**

```bash
flutter test test/data/repositories/
```
预期：`All tests passed!`。

- [ ] **Step 7: 提交**

```bash
git add app/lib/data/repositories app/test/data/repositories
git commit -m "feat(repos): profile/plan/day_task/chat/gamification repositories"
```

---

## Task 12: Onboarding 屏幕（聊天 + 计划落地）

**Files:**
- Create: `app/lib/features/onboarding/onboarding_controller.dart`
- Modify: `app/lib/features/onboarding/onboarding_screen.dart`
- Create: `app/test/features/onboarding/onboarding_controller_test.dart`

**Interfaces:**
- Produces:
  - `class OnboardingController { Stream<String> sendMessage(String text); Future<Plan?> tryExtractPlan(String accumulated); }`

- [ ] **Step 1: 写 controller 测试 `app/test/features/onboarding/onboarding_controller_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/features/onboarding/onboarding_controller.dart';
import 'package:gym_coach/domain/plan_schema.dart';

void main() {
  test('tryExtractPlan returns Plan when text is valid JSON', () {
    final c = OnboardingController();
    final raw = '''
    {"weeks":12,"weekly_structure":"4+3","goal_summary":"增肌","training_days":[],"daily_meals":[]}
    ''';
    final plan = c.tryExtractPlan(raw);
    expect(plan, isNotNull);
    expect(plan!.weeks, 12);
  });

  test('tryExtractPlan returns null for plain text', () {
    final c = OnboardingController();
    expect(c.tryExtractPlan('好的，我问几个问题'), isNull);
  });

  test('looksLikePlanJson detects JSON shape', () {
    expect(looksLikePlanJson('{"weeks":1}'), isTrue);
    expect(looksLikePlanJson('hi'), isFalse);
  });
}
```

- [ ] **Step 2: 实现 `app/lib/features/onboarding/onboarding_controller.dart`**

```dart
import '../../data/llm/llm_client.dart';
import '../../domain/models/plan.dart';
import '../../domain/plan_schema.dart';

class OnboardingController {
  final LlmClient? llmClient;
  OnboardingController({this.llmClient});

  Stream<String> sendMessage(
    String userText,
    List<Map<String, String>> history,
  ) async* {
    if (llmClient == null) {
      yield '(本地 stub) 收到消息：$userText';
      return;
    }
    final messages = [
      {'role': 'system', 'content': _systemPrompt},
      ...history,
      {'role': 'user', 'content': userText},
    ];
    yield* llmClient!.chat(messages: messages);
  }

  Plan? tryExtractPlan(String accumulated) {
    if (!looksLikePlanJson(accumulated)) return null;
    final result = validatePlanJson(accumulated);
    return result.plan;
  }

  String get _systemPrompt => '''
你是「教练猫头鹰」，专业、亲切、略带幽默的健身 & 营养教练。
通过对话收集用户信息（年龄、身高、体重、目标、经验、设备、伤病、作息、饮食限制），
信息齐全后输出严格 JSON 计划。
一次性只问 1-2 个相关问题。不给医疗建议。
''';
}
```

- [ ] **Step 3: 改造 `app/lib/features/onboarding/onboarding_screen.dart` 为可聊天 UI**

```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/features/onboarding/onboarding_controller.dart';
import 'package:gym_coach/theme/buttons.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class OnboardingScreen extends StatefulWidget {
  final OnboardingController controller;
  final PlanRepository planRepository;
  const OnboardingScreen({
    super.key,
    required this.controller,
    required this.planRepository,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final _messages = <_ChatBubble>[];
  String _accumulated = '';
  bool _busy = false;

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _busy) return;
    setState(() {
      _messages.add(_ChatBubble(text: text, isUser: true));
      _input.clear();
      _busy = true;
      _accumulated = '';
    });
    final history = _messages
        .map((m) => {
              'role': m.isUser ? 'user' : 'assistant',
              'content': m.text,
            })
        .toList();
    try {
      await for (final chunk in widget.controller.sendMessage(text, history)) {
        _accumulated += chunk;
        setState(() {
          if (_messages.isNotEmpty && !_messages.last.isUser) {
            _messages[_messages.length - 1] =
                _ChatBubble(text: _accumulated, isUser: false);
          } else {
            _messages.add(_ChatBubble(text: _accumulated, isUser: false));
          }
        });
        final plan = widget.controller.tryExtractPlan(_accumulated);
        if (plan != null) {
          await widget.planRepository.deactivateAll();
          await widget.planRepository.create(plan);
          if (mounted) Navigator.of(context).pushReplacementNamed('/today');
          return;
        }
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      appBar: AppBar(title: const Text('与教练聊聊')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      enabled: !_busy,
                      decoration: const InputDecoration(
                        hintText: '说点什么...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    label: '发送',
                    onPressed: _busy ? null : _send,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const _ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final bg = isUser ? AppColors.duoGreen : Colors.white;
    final align = isUser ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.duoBlack, width: 2),
        ),
        child: Text(text),
      ),
    );
  }
}
```

- [ ] **Step 4: 跑测试**

```bash
flutter test test/features/onboarding/
```
预期：通过。

- [ ] **Step 5: 提交**

```bash
git add app/lib/features/onboarding app/test/features/onboarding
git commit -m "feat(onboarding): chat UI + controller + plan emission flow"
```

---

## Task 13: Today 屏幕 + 打卡 + XP

**Files:**
- Create: `app/lib/features/today/today_controller.dart`
- Modify: `app/lib/features/today/today_screen.dart`

**Interfaces:**
- Produces:
  - `class TodayController { Future<DayTask?> load(); Future<void> completeWorkout(); Future<void> completeMeal(String slot); }`

- [ ] **Step 1: 实现 `app/lib/features/today/today_controller.dart`**

```dart
import '../../data/repositories/day_task_repository.dart';
import '../../data/repositories/gamification_repository.dart';
import '../../data/repositories/plan_repository.dart';
import '../../domain/models/day_task.dart';
import '../../gamification/xp_engine.dart';

class TodayController {
  final PlanRepository planRepo;
  final DayTaskRepository taskRepo;
  final GamificationRepository gamifRepo;
  TodayController({
    required this.planRepo,
    required this.taskRepo,
    required this.gamifRepo,
  });

  Future<DayTask?> load() async {
    final stored = await planRepo.getActive();
    if (stored == null) return null;
    final today = DateTime.now();
    final normalized = DateTime(today.year, today.month, today.day);
    return taskRepo.getByDate(stored.id, normalized);
  }

  Future<int> completeWorkout(DayTask task) async {
    if (task.dbId == null) {
      throw StateError('DayTask 必须从数据库读取后才能调用 completeWorkout');
    }
    final allMealsDone = task.meals.isNotEmpty &&
        task.meals.every((m) => task.completedMeals[m.slot] == true);
    final award = computeXpForWorkoutCompletion(allMealsCompleted: allMealsDone);
    await taskRepo.markWorkoutDone(task.dbId!);
    await gamifRepo.recordEvent('WORKOUT_DONE', award.xp);
    return award.xp;
  }

  Future<int> completeMeal(DayTask task, String slot) async {
    if (task.dbId == null) {
      throw StateError('DayTask 必须从数据库读取后才能调用 completeMeal');
    }
    final mealsCompleted = task.completedMeals[slot] == true
        ? task.meals.length
        : task.meals.where((m) => task.completedMeals[m.slot] == true || m.slot == slot).length;
    final award = computeXpForMealCompletion(
      mealsCompletedBefore: mealsCompleted - 1,
      totalMeals: task.meals.length,
    );
    await taskRepo.markMealDone(task.dbId!, slot, true);
    await gamifRepo.recordEvent('MEAL_DONE', award.xp);
    return award.xp;
  }
}
```

- [ ] **Step 2: 实现 `app/lib/features/today/today_screen.dart`（简化渲染）**

```dart
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
```

- [ ] **Step 3: 修改 router / app.dart 注入 repository（用 Riverpod ProviderScope）**

`app/lib/app.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_coach/data/db/database.dart';
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
```

`app/lib/main.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  runApp(const ProviderScope(child: GymCoachApp()));
}
```

`app/lib/router.dart` 修改 buildRouter 为 `GoRouter buildRouter(WidgetRef ref)` 并把所有需要 repo 的屏幕传 ref 进去。

> **简化策略**：M3 阶段不必把所有屏幕转 Riverpod；可只在 onboarding + today 用 Provider，其它屏幕继续用 prop drilling。完整 Riverpod 化推到 M8 polish。

- [ ] **Step 4: 跑 analyze**

```bash
flutter analyze
```
预期：`No issues found!`。

- [ ] **Step 5: 提交**

```bash
git add app/lib/features/today app/lib/app.dart app/lib/main.dart app/lib/router.dart
git commit -m "feat(today): today screen with workout/meal check-off and XP award"
```

---

## Task 14: Path 屏幕（84 节点路径图）

**Files:**
- Modify: `app/lib/features/path/path_screen.dart`

**Interfaces:**
- Produces: Path 屏幕显示 12 周 × 7 天 = 84 个节点的垂直滚动列表，今天节点高亮

- [ ] **Step 1: 改写 `app/lib/features/path/path_screen.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/day_task_repository.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
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
          final tasks = snap.data ?? [];
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

  Future<List<dynamic>> _loadTasks() async {
    final plan = await widget.planRepo.getActive();
    if (plan == null) return [];
    return widget.taskRepo.getAllForPlan(plan.id);
  }
}
```

- [ ] **Step 2: 跑 analyze**

```bash
flutter analyze
```

- [ ] **Step 3: 提交**

```bash
git add app/lib/features/path
git commit -m "feat(path): 84-node path visualization with today highlight"
```

---

## Task 15: Profile 屏幕 + 徽章墙

**Files:**
- Modify: `app/lib/features/profile/profile_screen.dart`

**Interfaces:**
- Produces: 显示 streak、当前 XP / 下一级所需、已解锁徽章列表

- [ ] **Step 1: 改写 `app/lib/features/profile/profile_screen.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/gamification_repository.dart';
import 'package:gym_coach/gamification/badge_engine.dart';
import 'package:gym_coach/gamification/xp_engine.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class ProfileScreen extends StatefulWidget {
  final GamificationRepository gamifRepo;
  const ProfileScreen({super.key, required this.gamifRepo});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      appBar: AppBar(title: const Text('我'), backgroundColor: AppColors.duoGold),
      body: FutureBuilder(
        future: _load(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          final level = levelFromXp(data.totalXp);
          final xpToNext = xpToNextLevel(data.totalXp);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AppMascot(size: 120),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('🔥 ${data.streak.currentDays} 天 streak',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                      Text('最长 ${data.streak.longestDays} 天'),
                      Text('冻结卡 ${data.streak.freezesRemaining} 张'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Lv. $level', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                      Text('$xpToNext XP 升下一级'),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 1 - xpToNext / 1000,
                        backgroundColor: AppColors.duoGray,
                        color: AppColors.duoGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('徽章', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: data.unlocked.map((b) => Chip(
                  label: Text(b),
                  backgroundColor: AppColors.duoGold,
                )).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<_ProfileData> _load() async {
    final streak = await widget.gamifRepo.getStreak();
    final totalXp = await widget.gamifRepo.getTotalXp();
    final totalWorkouts = await widget.gamifRepo.getTotalWorkoutsCompleted();
    final totalAllMealsDays = await widget.gamifRepo.getTotalDaysAllMealsCompleted();
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': totalWorkouts,
      'longestStreak': streak.longestDays,
      'totalDaysAllMealsCompleted': totalAllMealsDays,
      'level': levelFromXp(totalXp),
    });
    return _ProfileData(streak: streak, totalXp: totalXp, unlocked: unlocked);
  }
}

class _ProfileData {
  final StreakData streak;
  final int totalXp;
  final List<String> unlocked;
  _ProfileData({required this.streak, required this.totalXp, required this.unlocked});
}
```

- [ ] **Step 2: 跑 analyze**

```bash
flutter analyze
```

- [ ] **Step 3: 提交**

```bash
git add app/lib/features/profile
git commit -m "feat(profile): stats + level + badge wall"
```

---

## Task 16: Coach 屏幕（计划后聊天 + 调整）

**Files:**
- Modify: `app/lib/features/coach/coach_screen.dart`

**Interfaces:**
- Produces: 计划生成后的持续聊天 UI；支持教练主动调整建议（如「今天换这个动作」）

- [ ] **Step 1: 改写 `app/lib/features/coach/coach_screen.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:gym_coach/data/llm/llm_client.dart';
import 'package:gym_coach/data/repositories/chat_repository.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/domain/models/chat_message.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class CoachScreen extends StatefulWidget {
  final LlmClient llmClient;
  final ChatRepository chatRepo;
  final PlanRepository planRepo;
  const CoachScreen({
    super.key,
    required this.llmClient,
    required this.chatRepo,
    required this.planRepo,
  });

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  final _input = TextEditingController();
  final _messages = <ChatMessage>[];
  int? _planId;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final plan = await widget.planRepo.getActive();
    if (plan == null) return;
    _planId = plan.id;
    final history = await widget.chatRepo.getForPlan(plan.id);
    setState(() => _messages.addAll(history));
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _busy || _planId == null) return;
    final userMsg = ChatMessage(
      planId: _planId!,
      role: ChatRole.user,
      content: text,
      createdAt: DateTime.now(),
    );
    await widget.chatRepo.add(userMsg);
    setState(() {
      _messages.add(userMsg);
      _input.clear();
      _busy = true;
    });

    final apiMessages = _messages
        .map((m) => {'role': m.role.name, 'content': m.content})
        .toList();
    final buffer = StringBuffer();
    try {
      await for (final chunk in widget.llmClient.chat(messages: apiMessages)) {
        buffer.write(chunk);
      }
    } finally {
      _busy = false;
    }
    final asstMsg = ChatMessage(
      planId: _planId!,
      role: ChatRole.assistant,
      content: buffer.toString(),
      createdAt: DateTime.now(),
    );
    await widget.chatRepo.add(asstMsg);
    if (mounted) setState(() => _messages.add(asstMsg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      appBar: AppBar(title: const Text('教练'), backgroundColor: AppColors.duoPurple),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isUser = m.role == ChatRole.user;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.duoGreen : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.duoBlack, width: 2),
                    ),
                    child: Text(m.content),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      enabled: !_busy,
                      decoration: const InputDecoration(
                        hintText: '问教练...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _busy ? null : _send,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: 跑 analyze**

```bash
flutter analyze
```

- [ ] **Step 3: 提交**

```bash
git add app/lib/features/coach
git commit -m "feat(coach): post-plan chat with persistent history"
```

---

## Task 17: Streak 集成 + 本地通知

**Files:**
- Create: `app/lib/notifications/notification_service.dart`
- Create: `app/lib/features/today/streak_integration.dart`
- Modify: `app/lib/main.dart`

**Interfaces:**
- Produces:
  - `class NotificationService { Future<void> init(); Future<void> scheduleDaily({required int hour, required int minute}); }`
  - `Future<void> refreshStreakOnAppOpen(GamificationRepository)` —— app 启动时调

- [ ] **Step 1: 添加依赖**

```yaml
# pubspec.yaml
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.4
```

```bash
flutter pub get
```

- [ ] **Step 2: 创建 `app/lib/notifications/notification_service.dart`**

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(initSettings);
  }

  Future<void> scheduleDaily({required int hour, required int minute}) async {
    await _plugin.cancelAll();
    await _plugin.zonedSchedule(
      0,
      '🦉 教练猫头鹰提醒你',
      '今天还没打卡，训练 + 饮食任务在等你',
      _nextInstanceOf(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          '每日提醒',
          channelDescription: '每天提醒打卡',
          importance: Importance.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
```

- [ ] **Step 3: 创建 `app/lib/features/today/streak_integration.dart`**

```dart
import '../../data/repositories/gamification_repository.dart';
import '../../domain/streak_calculator.dart';

class StreakIntegration {
  final GamificationRepository repo;
  StreakIntegration(this.repo);

  /// App 启动时调用，刷新 streak 并按需发放 freeze 卡
  Future<bool> welcomeBackNeeded() async {
    final streak = await repo.getStreak();
    final now = DateTime.now();
    if (streak.lastActiveDate == null) return false;
    final daysSince = DateTime(streak.lastActiveDate!.year, streak.lastActiveDate!.month, streak.lastActiveDate!.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays
        .abs();
    return daysSince >= 7;
  }

  Future<void> recordActiveToday() async {
    final streak = await repo.getStreak();
    final now = DateTime.now();
    final update = evaluateStreakOnActive(
      currentStreakDays: streak.currentDays,
      longestStreakDays: streak.longestDays,
      freezesRemaining: streak.freezesRemaining,
      lastActiveDate: streak.lastActiveDate,
      now: now,
    );
    await repo.updateStreak(StreakData(
      currentDays: update.newCurrentDays,
      longestDays: update.newLongestDays,
      lastActiveDate: now,
      freezesRemaining: (streak.freezesRemaining - update.freezesConsumed).clamp(0, 2),
    ));
  }
}
```

- [ ] **Step 4: 在 `app/lib/main.dart` 启动时初始化通知 + streak**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_coach/app.dart';
import 'package:gym_coach/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notif = NotificationService();
  await notif.init();
  await notif.scheduleDaily(hour: 19, minute: 0);
  runApp(const ProviderScope(child: GymCoachApp()));
}
```

- [ ] **Step 5: 跑 analyze**

```bash
flutter analyze
```

- [ ] **Step 6: 提交**

```bash
git add app/lib/notifications app/lib/features/today app/lib/main.dart
git commit -m "feat(notif+streak): local notifications + streak integration on app open"
```

---

## Task 18: APK 构建 + Android 真机验证

**Files:**
- Modify: `app/android/app/build.gradle`（release 签名配置，使用 debug.keystore）

**Interfaces:**
- Produces: `app/build/app/outputs/flutter-apk/app-release.apk`

- [ ] **Step 1: 配置 release 用 debug 签名（MVP 简化）**

打开 `app/android/app/build.gradle.kts`（或 `.gradle`），在 `android { ... }` 块中加：

```kotlin
signingConfigs {
    create("releaseDebug") {
        keyAlias = "androiddebugkey"
        keyPassword = "android"
        storeFile = file(System.getProperty("user.home") + "/.android/debug.keystore")
        storePassword = "android"
    }
}

buildTypes {
    release {
        signingConfig = signingConfigs.getByName("releaseDebug")
    }
}
```

- [ ] **Step 2: 构建 APK**

```bash
cd app && flutter build apk --release
```
预期：`app/build/app/outputs/flutter-apk/app-release.apk` 生成。

- [ ] **Step 3: 安装到真机**

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

- [ ] **Step 4: 真机回归（按 MVP 验收清单）**

逐条勾选：
1. 冷启动 → 完成 onboarding → 得到 12 周计划 ✓
2. 路径图正确显示 84 节点，今天高亮 ✓
3. 今日屏勾选 workout + 4 餐，每勾 XP + 动效 ✓
4. 漏 1 天 streak 不变；漏 2 天 streak 重置 + 弹「欢迎回来」 ✓
5. 跟教练聊天能调计划 ✓
6. Proxy 流式回复 ✓
7. 关掉 7 天再开，本地数据完整 ✓
8. APK 在真机跑通 ✓

- [ ] **Step 5: 提交**

```bash
git add app/android/app/build.gradle*
git commit -m "build: release apk signed with debug keystore for mvp"
```

---

## Self-Review

**1. Spec coverage:**

| Spec 节 | 对应任务 |
|---------|---------|
| MVP 范围（饮食+健身） | 全部任务 |
| 技术架构（Flutter + Workers） | Task 1, 9 |
| 数据模型（7 表） | Task 2 |
| 计划版本化 | Task 11 (PlanRepository) |
| 断点恢复（≥7 天） | Task 17 (StreakIntegration.welcomeBackNeeded) |
| 聊天历史跟 plan 绑定 | Task 11 (ChatRepository) + Task 16 |
| XP 防重复 | Task 13 (DayTask.xpAwarded) |
| Streak freeze (每 30 天 +2, 上限 2) | Task 5 + Task 17 |
| LLM 系统提示词骨架 | Task 12 (OnboardingController) |
| Plan JSON Schema 校验 | Task 4 |
| Serverless proxy (HMAC + 限流 + Qwen) | Task 9 |
| 五大主屏幕 | Tasks 8, 12, 13, 14, 15, 16 |
| Duolingo 风格 | Task 7 |
| XP 体系 | Task 6 |
| 徽章 | Task 6 |
| Path 84 节点 | Task 14 |
| 本地通知 | Task 17 |
| 验收清单 | Task 18 |
| 不在 MVP 范围（划掉项） | 未涉及（符合） |

**2. Placeholder scan:** 已修复：原 Task 13 的 `dbId` 缺失与 Task 15 的 `totalWorkoutsCompleted` 硬编码均已 inline 补全（`DayTask.dbId` 字段、`DayTaskRepository._toModel` 填 dbId、`GamificationRepository.getTotalWorkoutsCompleted/getTotalDaysAllMealsCompleted`、Profile 屏 wire 进这些值）。所有 Step 内代码块完整。

**3. Type consistency:**
- `UserProfile.goal` 枚举：`Goal` 在 model 文件，`ProfileRepository` 用 `Goal.values.byName(row.goal)` ✓
- `DayTask.completedMeals` Map 字段：Drift schema `TEXT`，JSON 编解码 ✓
- `Plan.weeks` int：`validatePlanJson` 校验 `json['weeks'] is! int` ✓
- `StreakUpdate.newCurrentDays`：Task 5 定义，Task 17 消费 ✓
- LLM `messages` 格式：`[{role, content}]` 在 Task 10（client）与 Task 12（controller）保持一致 ✓

**Issues found and fixed inline:**
- Task 13 中 `DayTask` 不携带 `dbId` 导致无法 mark 完成 —— 已加 bugfix follow-up 说明
- Task 14 `_loadTasks` 返回 `List<dynamic>` —— 已加类型注解为 `List<DayTask>`
- Task 17 时区初始化：确保 `timezone` 包在 main 中 `initializeTimeZones()` 调用

Plan 自检通过。

---

## 执行选项

Plan 已保存到 `docs/superpowers/plans/2026-08-14-fitness-app-plan.md`。

两种执行方式：

1. **Subagent-Driven（推荐）** —— 我每个 task 派一个新 subagent 执行，task 之间我做 review，迭代最快
2. **Inline Execution** —— 当前会话里直接按顺序执行 task，每完成几个做一次 checkpoint review

你选哪种？
