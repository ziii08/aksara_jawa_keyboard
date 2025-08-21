part of in_app_keyboard;

/// Virtual keyboard actions.
enum KeyAction {
  Backspace,
  Return,
  Shift,
  Space,
  SwitchLanguage,
  Confirm,
  SwitchNumeric,
  SwitchAlphabetic,
  SwitchSpecial,
  SwitchNumber,
}

/// Shift states for virtual keyboard.
///
/// This enum defines the three possible shift states for the keyboard:
/// - [None]: Normal lowercase typing (default state)
/// - [Temporary]: Next character will be uppercase, then automatically reverts to [None]
/// - [CapsLock]: All characters will be uppercase until manually changed
///
/// The shift key cycles through these states: None → Temporary → CapsLock → None
enum ShiftState {
  /// No shift active - all characters will be lowercase
  None,

  /// Temporary shift - next character will be uppercase, then automatically returns to None
  Temporary,

  /// Caps lock - all characters will be uppercase until manually disabled
  CapsLock,
}
