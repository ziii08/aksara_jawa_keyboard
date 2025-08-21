# In App Flutter Keyboard

# About
A simple package for dispaying virtual keyboards on a devices like kiosks and ATMs. The library is written in Dart and has no native code dependancy.

This project has forked from `virtual_keyboard_multi_language` project. With this fork We are trying to make the library more customizable and user friendly with more interactivity and keys added.

We want to support industrial flutter developers that uses flutter linux products to use this library in their projects.

## Features:
- Multi-language support with custom language layout.
- Customizable keyboard style.
- Customizable keys.
- Auto show keyboard on text form click.
- Auto hide keyboard on text form unfocus.
- **Advanced Shift Support**: Temporary shift and caps lock functionality
  - None: Normal lowercase typing
  - Temporary: Next character will be uppercase, then automatically returns to lowercase
  - Caps Lock: All characters will be uppercase until manually disabled

## Shift Feature

The keyboard now supports three shift states that cycle when the shift key is pressed:

1. **None** (Default): All characters are lowercase
2. **Temporary Shift**: Next character will be uppercase, then automatically returns to lowercase
3. **Caps Lock**: All characters remain uppercase until shift is pressed again

### Visual Indicators:
- **None**: Standard arrow up icon (↑)
- **Temporary**: Filled arrow up icon (↑) in blue color
- **Caps Lock**: Caps lock icon (⇪) in green color

### Usage Example:

```dart
AppKeyboard(
  focusNodes: [focusNode],
  textControllers: [textController],
  keyboardTypes: [KeyboardType.Alphanumeric],
  onShow: (isShow) {
    print('Keyboard is ${isShow ? 'visible' : 'hidden'}');
  },
  onShiftStateChanged: (shiftState) {
    print('Shift state changed to: ${shiftState}');
    // Handle shift state changes
    // shiftState can be: ShiftState.None, ShiftState.Temporary, or ShiftState.CapsLock
  },
)
```

### Shift State Management:

You can also programmatically control the shift state:

```dart
// Get the keyboard widget reference
final keyboardKey = GlobalKey<KeyboardState>();

// Set shift state programmatically
keyboardKey.currentState?.setShiftState(ShiftState.CapsLock);

// Check current shift state
ShiftState currentState = keyboardKey.currentState?.currentShiftState ?? ShiftState.None;

// Check if shift is active
bool isActive = keyboardKey.currentState?.isShiftActive ?? false;
```