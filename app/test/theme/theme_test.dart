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
