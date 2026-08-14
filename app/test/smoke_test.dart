import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/config.dart';

void main() {
  test('AppConfig exposes proxyEndpoint and hmacSecret', () {
    expect(AppConfig.proxyEndpoint, isNotEmpty);
    expect(AppConfig.hmacSecret, isNotEmpty);
  });
}