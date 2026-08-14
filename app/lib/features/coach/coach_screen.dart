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
