part of in_app_keyboard;

/// Keys for Virtual Keyboard's rows.
const List<List> _keyRowsNumeric = [
  // Row 1
  const [
    '1',
    '2',
    '3',
  ],
  // Row 1
  const [
    '4',
    '5',
    '6',
  ],
  // Row 1
  const [
    '7',
    '8',
    '9',
  ],
  // Row 1
  const [
    // '.',
    '0',
  ],
];

/// Returns a list of `VirtualKeyboardKey` objects for Numeric keyboard.
List<KeyboardKey> _getKeyboardRowKeysNumeric(rowNum) {
  // Generate VirtualKeyboardKey objects for each row.
  return List.generate(_keyRowsNumeric[rowNum].length, (int keyNum) {
    // Get key string value.
    String key = _keyRowsNumeric[rowNum][keyNum];

    // Create and return new VirtualKeyboardKey object.
    return KeyboardKey(
      text: key,
      capsText: key.toUpperCase(),
      keyType: KeyboardKeyType.String,
    );
  });
}

/// Returns a list of `VirtualKeyboardKey` objects.
List<KeyboardKey> _getKeyboardRowKeys(KeyboardLayoutKeys layoutKeys, rowNum) {
  // Generate VirtualKeyboardKey objects for each row.
  return List.generate(layoutKeys.activeLayout[rowNum].length, (int keyNum) {
    // Get key string value.
    if (layoutKeys.activeLayout[rowNum][keyNum] is String) {
      String key = layoutKeys.activeLayout[rowNum][keyNum];

      // Create and return new VirtualKeyboardKey object.
      return KeyboardKey(
        text: key,
        capsText: key.toUpperCase(),
        keyType: KeyboardKeyType.String,
      );
    } else {
      var action = layoutKeys.activeLayout[rowNum][keyNum] as KeyAction;
      return KeyboardKey(keyType: KeyboardKeyType.Action, action: action);
    }
  });
}

/// Returns a list of VirtualKeyboard rows with `VirtualKeyboardKey` objects.
List<List<KeyboardKey>> _getKeyboardRows(KeyboardLayoutKeys layoutKeys) {
  // Generate lists for each keyboard row.
  return List.generate(layoutKeys.activeLayout.length,
      (int rowNum) => _getKeyboardRowKeys(layoutKeys, rowNum));
}

/// Returns a list of VirtualKeyboard rows with `VirtualKeyboardKey` objects.
List<List<KeyboardKey>> _getKeyboardRowsNumeric() {
  // Generate lists for each keyboard row.
  return List.generate(_keyRowsNumeric.length, (int rowNum) {
    // Will contain the keyboard row keys.
    List<KeyboardKey> rowKeys = [];

    // We have to add Action keys to keyboard.
    switch (rowNum) {
      case 3:
        // String keys.

        // Right Shift
        rowKeys.add(
          KeyboardKey(
              keyType: KeyboardKeyType.Action, action: KeyAction.Confirm),
        );

        rowKeys.addAll(_getKeyboardRowKeysNumeric(rowNum));

        rowKeys.add(
          KeyboardKey(
              keyType: KeyboardKeyType.Action, action: KeyAction.Backspace),
        );

        break;
      default:
        rowKeys = _getKeyboardRowKeysNumeric(rowNum);
    }

    return rowKeys;
  });
}
