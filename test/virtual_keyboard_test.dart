import 'package:flutter_test/flutter_test.dart';

import 'package:in_app_keyboard/in_app_keyboard.dart';

void main() {
  test('creates keyboard widget with Alphanumeric type', () {
    final keyboard = Keyboard(
      type: KeyboardType.Alphanumeric,
      onKeyPress: () => null,
    );
    expect(keyboard.type, KeyboardType.Alphanumeric);
  });
}
