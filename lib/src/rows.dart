part of in_app_keyboard;

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
