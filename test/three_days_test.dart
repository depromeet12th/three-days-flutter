import 'package:flutter_test/flutter_test.dart';
import 'package:three_days/auth/login_type.dart';

void main() {
  test('LoginType has 2 providers', () {
    expect(LoginType.values.length, 2);
  });
}
