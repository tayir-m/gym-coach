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
