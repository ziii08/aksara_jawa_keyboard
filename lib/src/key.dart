part of in_app_keyboard;

class KeyboardKey {
  String? text;
  String? capsText;
  final KeyboardKeyType keyType;
  final KeyAction? action;

  KeyboardKey({this.text, this.capsText, required this.keyType, this.action}) {
    if (this.text == null && this.action != null) {
      this.text = action == KeyAction.Space
          ? ' '
          : (action == KeyAction.Return ? '\n' : '');
    }
    if (this.capsText == null && this.action != null) {
      this.capsText = action == KeyAction.Space
          ? ' '
          : (action == KeyAction.Return ? '\n' : '');
    }
  }
}
