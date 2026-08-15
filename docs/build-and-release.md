# Build & Release — Android APK

How to turn the `app/` Flutter source tree into an installable `app-release.apk`
and verify it on a real Android device.

> **This has not been executed yet.** The dev environment used to author Tasks
> 1–18 (Termux on Android ARM64) has no Flutter SDK, no Android SDK, no JDK and
> no target device. Everything below is the exact procedure to run on a proper
> dev box. If you don't have a dev box handy, use the GitHub Actions workflow
> at `.github/workflows/build-apk.yml` — see the CI section at the bottom.

## CI — GitHub Actions (recommended when no dev box)

`.github/workflows/build-apk.yml` runs `flutter pub get` → `build_runner` →
`flutter analyze` → `flutter test` → `flutter build apk --release` on every
push to `feat/mvp-implementation` / `main`, and uploads the APK as a
downloadable artifact. Override defaults via repo **Settings → Secrets and
variables → Actions → Variables**:

| Variable | Default | Purpose |
|---|---|---|
| `PROXY_ENDPOINT` | `https://gym.qisqaisim.xyz` | Cloudflare Workers proxy URL |
| `HMAC_SECRET` | `dev-secret-change-me` | Shared secret for HMAC sig |

Trigger manually from the Actions tab via **Run workflow**, or wait for the
next push. The APK is at
`app-release` artifact → `app-release.apk`.

> **Note from CN network**: GitHub is unreachable from Termux in this
> project. Push from a network that can reach `github.com`, or mirror to
> `gitee.com/<user>/<repo>` and adapt the workflow — Gitee Go uses the same
> YAML but `ubuntu-latest` is `ubuntu:22.04` and the action set differs.

## Prerequisites

| Requirement | Version / note |
|---|---|
| Flutter SDK | ≥ 3.16 (`pubspec.yaml` pins `flutter: '>=3.16.0'`, `sdk: '>=3.0.0 <4.0.0'`) |
| Android SDK | platform 34 + build-tools 34 (`sdkmanager "platforms;android-34"`) |
| JDK | 17 (required by the Android Gradle Plugin used by Flutter 3.16+) |
| Device | Real Android phone, Developer options + USB debugging enabled |
| `adb` | On `PATH`, device visible via `adb devices` |

## Step 1 — Generate platform folders

The repo intentionally contains only `app/lib`, `app/test` and `app/pubspec.yaml`.
The `android/` and `ios/` folders are **not** checked in and must be generated:

```bash
cd app
flutter create . --org com.gymcoach --project-name gym_coach --platforms=android,ios
```

`flutter create .` on an existing directory only adds missing platform
scaffolding — it preserves `lib/`, `test/` and `pubspec.yaml`. Afterwards:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

The `build_runner` step is **mandatory** — see "Known gaps" below.

## Step 2 — Apply release signing config

MVP simplification: sign the release build with the standard debug keystore.
Open `app/android/app/build.gradle.kts` (Kotlin DSL; older Flutter templates
emit Groovy `build.gradle` instead) and add inside the `android { ... }` block:

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

If the template is Groovy, drop the `=` assignments and the `create(...)`
wrapper (`releaseDebug { keyAlias 'androiddebugkey' ... }`).

This APK is **not** shippable to Play Store — replace with a real upload
keystore before any public release.

## Step 3 — Build the APK

```bash
cd app && flutter build apk --release
```

Expected artifact: `app/build/app/outputs/flutter-apk/app-release.apk`

## Step 4 — Install on device

```bash
adb devices                                             # confirm device attached
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

## Step 5 — Manual verification checklist (MVP 验收清单)

1. 冷启动 → 完成 onboarding → 得到 12 周计划 — *Task 12 (onboarding), Task 4 (plan schema), Task 11 (PlanRepository)*
2. 路径图正确显示 84 节点，今天高亮 — *Task 14*
3. 今日屏勾选 workout + 4 餐，每勾 XP + 动效 — *Task 13 (screen), Task 6 (XP engine)* — see FutureBuilder gap below
4. 漏 1 天 streak 不变；漏 2 天 streak 重置 + 弹「欢迎回来」 — *Task 5 (calculator), Task 17 (integration)*
5. 跟教练聊天能调计划 — *Task 16 (coach screen), Task 11 (ChatRepository)*
6. Proxy 流式回复 — *Task 9 (Workers proxy), Task 10 (Flutter LLM client)*
7. 关掉 7 天再开，本地数据完整 — *Task 2 (Drift schema), Task 17 (welcome-back)*
8. APK 在真机跑通 — *this task*

## Known gaps to address before shipping

Carried over from the Task 17 report; all still open:

1. **Freeze cards dormant** — `shouldAwardFreeze()` (`app/lib/domain/streak_calculator.dart`)
   is never called from `recordActiveToday`, so the "every 30 days grant +1 freeze,
   cap 2" rule never fires.
2. **Missing freeze-award bookkeeping** — `StreakData` has no `lastFreezeAwardDate`
   field and the `streaks` table has no matching column. Wiring gap 1 requires a
   Drift schema bump to v2 plus a migration.
3. **Android 13+ notification permission** — `NotificationService` never requests
   `POST_NOTIFICATIONS`; on API 33+ reminders silently never appear.
4. **Today screen does not refresh** — `TodayScreen` uses a one-shot
   `FutureBuilder`, so the UI does not update after `completeWorkout` /
   `completeMeal` until the next rebuild. This is a brief-mandated UX bug from
   Task 13 and will be visible during checklist item 3.
5. **`database.g.dart` is a hand-authored stub** — `app/lib/data/db/database.g.dart`
   reproduces the public surface of generated code by hand because build_runner
   could not run. Regenerate with
   `dart run build_runner build --delete-conflicting-outputs` before trusting any
   build.
6. **Manual JSON encoders in PlanRepository** — `app/lib/data/repositories/plan_repository.dart`
   uses `_trainingDayToJson` / `_dailyMealsToJson` because the hand-authored
   freezed stubs lack `TrainingDay.toJson()` / `DailyMeals.toJson()`. After
   regeneration, delete these helpers and use the canonical encoders.

## Environment note — Termux / Android ARM64

This repo was authored on Termux (Android ARM64), where prebuilt toolchain
binaries are frequently unavailable. `proxy/README.md` documents the analogous
workaround for the Workers proxy (`npm install --ignore-scripts`, because
`workerd` ships no ARM64-Android binary).

The Flutter SDK has the same class of problem — the bundled Dart SDK, Gradle and
the Android build-tools have no Termux-native builds. **Do not attempt the steps
above on Termux.** Use a Linux or macOS dev box (or CI) for `flutter create`,
`build_runner`, `flutter build apk` and `wrangler deploy`. `adb` alone works
under Termux and can be used for Step 4 if a device is attached via OTG.
