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