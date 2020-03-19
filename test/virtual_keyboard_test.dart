import 'package:flutter_test/flutter_test.dart';

import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

void main() {
  test('creates keyboard widget with Alphanumeric type', () {
    final keyboard = VirtualKeyboard(
      type: VirtualKeyboardType.Alphanumeric,
      onKeyPress: () => null,
    );
    expect(keyboard.type, VirtualKeyboardType.Alphanumeric);
  });
}
