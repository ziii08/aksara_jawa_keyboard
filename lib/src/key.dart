part of aksara_jawa_keyboard;

class KeyboardKey {
  String? text;
  final KeyboardKeyType keyType;
  final KeyAction? action;

  KeyboardKey({this.text, required this.keyType, this.action}) {
    if (this.text == null && this.action != null) {
      this.text = action == KeyAction.Space ? ' ' : '';
    }
  }
}
