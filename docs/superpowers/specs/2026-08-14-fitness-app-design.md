# 健身 APP 设计文档

**日期**：2026-08-14
**状态**：待用户复核
**作者**：brainstorming 协作产出

## 一句话定位

一款 Duolingo 式游戏化的健身 & 饮食计划 app，通过国内大模型（Qwen/豆包）以对话方式收集用户信息并生成个性化多周计划，本地优先存储，断点续做不丢记忆。

## 目标用户 & 场景

- 想系统健身但没时间研究的人
- 容易三天打鱼两天晒网的人（streak 是核心机制）
- 中文用户，国内网络环境，无 VPN
- 用户场景：「练了一个月停了两周又有时间，继续」必须丝滑

## MVP 范围

**包含**：

- 跟 LLM 教练的对话式 onboarding（收集档案）
- 一次性生成多周（默认 12 周）统一计划（训练 + 饮食）
- 每日任务卡（workout + 4 餐）勾选系统
- Duolingo 式游戏化（streak / XP / 等级 / 徽章）
- 路径图展示整段计划进度
- 计划生成后的持续聊天调整
- 断点续做（漏打卡检测 + streak freeze）
- 本地通知（每日提醒）
- Android APK 真机可跑

**不包含（明确划掉）**：

- 多用户账号 / 云同步
- 社交（好友、动态、PK）
- 动作视频示范（文字 + Lottie 示意代替）
- 智能硬件集成
- iOS 上架（M1 不交付 iOS 构建，需要 Mac）
- 多语言（先中文 zh-CN）
- 支付 / 会员 / 广告

## 技术架构

```
┌─────────────────────────────────────────────────────────┐
│  Flutter App（iOS + Android，MVP 阶段只交付 Android APK）│
│  ┌──────────┐  ┌──────────┐  ┌─────────────────────┐   │
│  │ Onboarding│  │  Daily   │  │  Coach Chat（计划后 │   │
│  │  Chat     │  │  Quests  │  │  调整 / 答疑）       │   │
│  └────┬─────┘  └────┬─────┘  └──────────┬──────────┘   │
│       └──────────────┴──────────────────┘               │
│                       │                                  │
│              ┌────────▼─────────┐                       │
│              │ Drift 本地 DB    │  profile / plan /      │
│              │ （SQLite）       │  day_task / chat /     │
│              └────────┬─────────┘  streak / 徽章        │
│                       │                                  │
│              ┌────────▼─────────┐                       │
│              │ LLM client       │ ←→ serverless proxy   │
│              └──────────────────┘                       │
│  ┌──────────────────────┐                               │
│  │ 游戏化层             │  streak / XP / 徽章 / 吉祥物  │
│  └──────────────────────┘                               │
│  ┌──────────────────────┐                               │
│  │ 本地通知             │  flutter_local_notifications │
│  └──────────────────────┘                               │
└─────────────────────────────────────────────────────────┘
                          │ HTTPS（SSE 流式）
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Serverless Proxy（阿里云函数计算 FC，免费额度内）       │
│   · 持有 LLM API Key（Qwen / 豆包）                    │
│   · POST /v1/chat → 流式 SSE 转给 app                   │
│   · 共享 secret 签名校验                                 │
│   · 粗粒度限流 + 月预算熔断                              │
│   · 不存储任何用户数据，只记元日志                       │
└─────────────────────────────────────────────────────────┘
```

**关键边界**：

- App 本地优先，用户数据永不离开设备
- Proxy 无状态，仅在请求生命周期内转发消息
- 每次 LLM 请求的 context 在 app 端组装完整后发出

## 详细组件设计

### 1. 本地数据模型（Drift / SQLite）

```sql
-- 用户档案
user_profile (
  id, age, height_cm, weight_kg, sex,
  goal TEXT,                -- 增肌/减脂/保持/力量
  experience TEXT,          -- 入门/中级/高级
  equipment TEXT,           -- JSON 数组
  injuries TEXT,
  dietary_notes TEXT,
  daily_schedule TEXT,      -- 可用时段
  updated_at
)

-- 计划（每次重新生成 = 新版本）
plan (
  id, version INT,
  start_date, weeks INT,
  plan_json TEXT,           -- LLM 输出完整结构
  created_at, active BOOL
)

-- 每日任务（plan_json 拆出，便于打卡）
day_task (
  id, plan_id, day_index INT,
  date,
  workout_json TEXT,
  meals_json TEXT,
  completed_workout BOOL,
  completed_meals JSON,     -- {breakfast, lunch, dinner, snack}
  xp_awarded INT,           -- 防重复加分
  completed_at
)

-- 对话历史（按 plan 分组）
chat_message (
  id, plan_id, role, content, created_at
)

-- streak
streak (
  id, current_days INT, longest_days INT,
  last_active_date,
  freezes_remaining INT     -- 默认每 30 天 +2，上限 2
)

-- 游戏化事件（用于审计 / 回放）
gamification_event (
  id, event_type, value INT, created_at
)

-- 徽章定义
badge (code, name, description, icon, condition_json)
```

**关键机制**：

- **计划版本化**：重新生成计划时旧 plan 标记 `active=false`，新 plan 接管；`day_task` 按 `plan_id` 隔离
- **断点恢复**：`today - last_active_date >= 7` 触发「欢迎回来」LLM 续聊
- **聊天历史跟 plan 绑定**：换计划时老聊天保留但默认不喂给新 plan
- **XP 防重复**：`day_task.xp_awarded` 字段确保重开 app 不重复加分
- **Streak freeze**：每 30 天自动 +2 张，上限 2 张，漏打卡时自动消耗

### 2. LLM 交互协议

#### 系统提示词骨架

```
你是「教练猫头鹰」，专业、亲切、略带幽默的健身 & 营养教练。
- 任务 1：收集用户信息（年龄、身高、体重、目标、经验、设备、伤病、作息、饮食限制），
  通过自然对话逐一问到。
- 任务 2：信息齐全后，输出严格 JSON 计划（schema 见设计文档）。
- 任务 3：计划生成后，继续作为教练答疑、调整计划。
- 严格规则：
  · 一次性只问 1-2 个相关问题
  · 不给医疗建议，伤病相关建议看医生
  · 计划动作严格适配用户标注的设备
  · 输出 JSON 时只输出 JSON，不要前后夹注释
```

#### 计划 JSON Schema

```json
{
  "weeks": 12,
  "weekly_structure": "4 天训练 + 3 天休息",
  "goal_summary": "12 周减脂 + 保留肌肉",
  "training_days": [
    {
      "week": 1, "day_of_week": 1,
      "title": "上肢推（胸/肩/三头）",
      "focus": "增肌",
      "estimated_minutes": 45,
      "exercises": [
        {
          "name": "哑铃卧推",
          "sets": 4, "reps": "8-12",
          "rest_seconds": 90,
          "notes": "力竭前 1-2 次停"
        }
      ]
    }
  ],
  "daily_meals": [
    {
      "week": 1, "day_of_week": 1,
      "total_kcal": 2200, "protein_g": 160, "carbs_g": 220, "fat_g": 70,
      "meals": [
        {"slot": "breakfast", "name": "...", "kcal": 480,
         "protein_g": 30, "carbs_g": 60, "fat_g": 12,
         "ingredients": ["..."]},
        {"slot": "lunch", ...},
        {"slot": "dinner", ...},
        {"slot": "snack", ...}
      ]
    }
  ]
}
```

#### LLM 输出模式

| 模式 | 触发 | 输出 |
|------|------|------|
| `chat` | 收集中 / 答疑中 | 普通文本 |
| `plan_emit` | 信息齐全后 | 仅 JSON，app 端 schema 校验后写入 `plan.plan_json` |

LLM 在收集中途输出普通文本；app 检测到输出形如 `{...}` 的纯 JSON（且通过 schema 校验），即视为 plan 落地。

#### 喂给 LLM 的 Context

每次请求：

1. `system_prompt`（教练人格）
2. `user_profile`
3. 当前 plan（若有）+ 今天 day_task 摘要
4. 最近 7 天完成情况
5. streak / 漏打卡天数
6. 完整 `chat_message` 历史

全部在 app 端组装后一次性发出。

#### 失败 / 异常处理

- LLM 输出无法解析为 JSON → 回退 `chat` 模式，让用户重说「请生成计划」
- LLM 超时（>30s） → app 提示「教练走神了，再点一次」
- Proxy 月预算触顶 → 返 503，app 显示友好提示
- 用户网络断 → 本地继续记录完成情况，恢复后再同步

#### 断点续聊

- 检测 `today - last_active_date >= 7` → 启动时弹「欢迎回来，停了 X 天，要继续吗？」
- 用户确认 → 进入 chat，LLM context 注入「已停 X 天，上次完成到第 N 天 M 个任务」
- LLM 可建议：原地续 / 跳过休息日 / 降阶重启
- 不强制，用户可选择忽略

### 3. Serverless Proxy 契约

#### 部署

**阿里云函数计算 FC**（推荐）：

- 每月 100 万次免费调用
- 国内访问稳定，Qwen/豆包 API 同生态
- 需要备案域名（一次性）

#### 端点

`POST /v1/chat`

**请求**：
```json
{
  "messages": [{"role": "...", "content": "..."}],
  "model": "qwen-plus",
  "stream": true,
  "temperature": 0.7
}
```

**响应**：Server-Sent Events，逐 token 流式推送。

Proxy 不接收也不存储任何用户数据，仅作为转发层。

#### 代码结构

```
proxy/
├── src/
│   ├── index.ts          # 入口
│   ├── llm-client.ts     # Qwen/Doubao 适配
│   ├── auth.ts           # HMAC 签名校验
│   └── rate-limit.ts     # 粗粒度限流
├── package.json
└── deploy.md             # 阿里云 FC 部署步骤
```

- TypeScript + Hono 框架
- 单文件即可上线
- 部署后拿到 HTTPS endpoint，写入 Flutter app 的 `lib/config.dart`

#### 安全

| 措施 | 说明 |
|------|------|
| 共享 secret（HMAC） | app 与 proxy 之间预共享 secret 做签名，防重放 |
| API Key 仅存 proxy | 绑死环境变量，永不出 serverless |
| 月预算熔断 | 记录本月 token 总量，超阈值返 503 |
| 输入大小限制 | 单次请求 ≤ 64KB |
| 日志脱敏 | 仅记时间、token 数、响应时长 |

#### 成本估算

- 单用户 onboarding：~¥0.18
- 单次日常 chat：~¥0.024
- 单次计划生成：~¥0.012
- 用户首月总成本：¥0.5 以内
- 100 用户首月 ≈ ¥50，远在阿里云免费额度内

#### Flutter 端 LLM Client

- 用 `http` 包流式请求 SSE
- 自定义 `SseEventTransformer` 拼装 chunk
- 指数退避重试，最多 3 次
- 网络断开时本地暂存，恢复后补发

### 4. UI & 游戏化

#### 五大主屏幕

| 屏幕 | Duolingo 对应 | 健身版内容 |
|------|-------------|------------|
| Today | 今日课程 | 1 个 workout + 4 个 meal 卡片 |
| Path | 主地图 | 12 周计划的 84 节点路径 |
| Coach | Stories/聊天 | 与 LLM 教练的对话 |
| Profile | 个人页 | 体重趋势、streak、徽章墙、设置 |
| Onboarding | 首次体验 | 多轮聊天引导填档案 |

#### Duolingo 风格视觉元素

- 吉祥物「教练猫头鹰」贯穿所有互动反馈
- 品牌色：绿 `#58CC02`、紫 `#CE82FF`、金 `#FFC800`、红 `#FF4B4B`
- 粗描边按钮（2px 黑边 + 阴影，按下下沉 2px）
- 完成动画：confetti、按钮弹跳、吉祥物欢呼
- `HapticFeedback.mediumImpact()` 触觉反馈
- 乐观文案，漏打卡不写「失败」

#### Today 屏呈现

- 顶部固定：streak 🔥、XP / 下一级所需、未读消息红点
- 训练和饮食分开打卡（避免一顿饭没吃就全盘失败）
- 饮食卡显示 kcal 进度条

#### XP 体系

| 行为 | XP |
|------|-----|
| 完成当天 workout | +30 |
| 完成当天 4 餐全部 | +20 |
| 全部任务当日完成 | +50（额外） |
| 连胜 7 天里程碑 | +100 |
| 解锁徽章 | +200 |
| 按教练建议调整 | +10 |

- 每 1000 XP 升一级，1-10 级有称号（萌新 → 雏鹰 → 飞鹰 → 雄鹰...）

#### Streak Freeze

- 每 30 天自动获得 2 张 freeze card
- 上限 2 张
- 漏打卡时自动消耗，streak 不中断

#### 徽章示例

- 首战告捷 — 完成第 1 次训练
- 一周不停 — 7 天 streak
- 铁胃 — 连续 7 天 4 餐全打卡
- 百日筑基 — 100 天 streak
- 健身猫头鹰 — 升级到 10 级

#### Path 屏

- 12 周计划（84 天）画成带节点的路
- 已完成：实心绿；今天：脉动发光；未来：灰色；漏掉的：灰色虚线（可补做）
- 长 milestone（4 / 8 / 12 周）：紫色大节点 + 奖杯

## 仓库结构

```
gym/                              # 当前目录
├── app/                          # Flutter app
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app.dart              # MaterialApp + Riverpod
│   │   ├── theme/                # Duolingo 风格
│   │   ├── data/
│   │   │   ├── db/               # Drift schema + DAO
│   │   │   ├── repositories/
│   │   │   └── llm/              # LLM client + SSE 解析
│   │   ├── features/
│   │   │   ├── onboarding/
│   │   │   ├── today/
│   │   │   ├── path/
│   │   │   ├── coach/
│   │   │   └── profile/
│   │   ├── domain/               # 纯 Dart 业务逻辑
│   │   ├── gamification/         # streak / XP / 徽章引擎
│   │   └── notifications/
│   ├── test/
│   ├── android/
│   ├── ios/                      # 后期需要 Mac
│   └── pubspec.yaml
├── proxy/                        # Serverless proxy
│   ├── src/
│   ├── package.json
│   └── deploy.md
├── docs/
│   └── superpowers/
│       └── specs/
└── README.md
```

## 关键依赖（Flutter 端）

| 包 | 用途 |
|----|------|
| `flutter_riverpod` | 状态管理 |
| `drift` + `drift_flutter` | 本地 SQLite |
| `http` | LLM client 流式 |
| `flutter_local_notifications` | 每日提醒 |
| `fl_chart` | 体重/卡路里趋势图 |
| `lottie` | 猫头鹰动画 |
| `freezed` + `json_serializable` | 不可变 model |
| `flutter_animate` | confetti / 庆祝动效 |
| `path_provider` | DB 文件路径 |
| `intl` | 中文本地化 |

## 测试策略

| 层 | 测试类型 | 覆盖目标 |
|----|---------|---------|
| `domain/` | 单元测试 | streak 计算、XP 规则、计划日期推算、断点检测、JSON schema 校验 |
| `data/repositories/` | 单元 + 内存 SQLite | DAO CRUD、plan 版本切换 |
| `data/llm/` | 单元（mock http） | SSE 解析、重试、错误码映射 |
| `gamification/` | 单元测试 | XP/streak/freeze 边界条件 |
| `features/*` | Widget 测试 | 关键屏幕渲染 |
| `proxy/` | 集成（vitest） | 签名校验、限流、LLM 转发 mock |

**不测**：LLM 输出内容；UI 像素细节；iOS 上架审核。

## 验收标准

MVP 完工定义：

1. 用户能从冷启动 → 完成 onboarding → 得到 12 周计划
2. 路径图正确显示 84 节点，今天高亮
3. 今日屏能勾选 workout + 4 餐，每勾一项 XP + 动效
4. 漏打卡 1 天 streak 不变（消耗 freeze）；漏 2 天 streak 重置并弹「欢迎回来」
5. 跟教练聊天能调整计划（动作换 / 餐量加减），新一天内容随之更新
6. Proxy 部署阿里云 FC，app 稳定流式收到回复
7. 关掉 app 7 天再打开，本地数据完整恢复
8. APK 能装到 Android 真机跑通

## 里程碑（单人开发估时）

| 阶段 | 交付 | 估时 |
|------|------|------|
| M1 骨架 | Drift schema + 主题 + 五大空屏 + 路由 | 1-2 天 |
| M2 Onboarding | LLM client + onboarding 屏 + 计划落地 | 2-3 天 |
| M3 Today + 打卡 | 今日屏 + XP 引擎 + 勾选动画 | 1-2 天 |
| M4 Path + Profile | 路径图 + 徽章墙 | 1-2 天 |
| M5 Coach 聊天 | 计划后聊天 + 调整计划 | 1-2 天 |
| M6 Streak + 提醒 | streak freeze + 本地通知 | 1 天 |
| M7 Proxy 上线 | 阿里云 FC 部署 + 联调 | 1 天 |
| M8 APK 真机 | Android 真机回归 | 1-2 天 |

合计 **~10-15 天**（不含 iOS 构建）。

## 开放问题（M1 阶段需解决）

- LLM 具体选 Qwen-Plus 还是 豆包 Pro？建议先 Qwen-Plus（中文 + 工具调用友好），如发现质量问题再切豆包
- 阿里云 FC 备案域名是否已有？没有的话需要先申请（备案通常 7-20 天）
- 体重趋势数据：app 启动时让用户输入当前体重，之后手动更新（不接入秤）
- 漏打卡超过 30 天的极端情况：streak 重置，LLM 重新评估是否需要降阶重启

## 后续路线（M1 之后）

- iOS 上架（需 Mac）
- 计划后聊天支持图片（教练示范动作截图）
- 智能硬件（体重秤 / 手表）接入
- 多语言（先 zh-CN，i18n 架构预留）
- 计划模板市场（社区共享模板，LLM 微调生成）
