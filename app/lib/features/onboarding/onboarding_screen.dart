import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/plan_repository.dart';
import 'package:gym_coach/features/onboarding/onboarding_controller.dart';
import 'package:gym_coach/theme/buttons.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:go_router/go_router.dart';

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
          if (mounted) context.go('/today');
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