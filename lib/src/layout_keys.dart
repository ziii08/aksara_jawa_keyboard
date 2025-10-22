part of aksara_jawa_keyboard;

abstract class KeyboardLayoutKeys {
  int activeIndex = 0;
  KeyboardLayoutType layoutType = KeyboardLayoutType.Main;

  List<List> get mainKeyboardLayout => _mainKeyboardLayout;
  List<List> get shiftKeyboardLayout => _shiftKeyboardLayout;
  List<List> get numberKeyboardLayout => _numberKeyboardLayout;

  List<List> get activeLayout => getLayout(layoutType, activeIndex);
  List<List> getLayout(KeyboardLayoutType layout, int index);

  void switchMain() {
    layoutType = KeyboardLayoutType.Main;
  }

  void switchNumber() {
    layoutType = KeyboardLayoutType.Number;
  }

  void switchShift() {
    layoutType = KeyboardLayoutType.Shift;
  }
}

class AksaraJawaKeyboard extends KeyboardLayoutKeys {
  @override
  List<List> getLayout(KeyboardLayoutType layout, int index) {
    switch (layout) {
      case KeyboardLayoutType.Main:
        return _mainKeyboardLayout;
      case KeyboardLayoutType.Shift:
        return _shiftKeyboardLayout;
      case KeyboardLayoutType.Number:
        return _numberKeyboardLayout;
    }
  }
}

const List<List> _mainKeyboardLayout = [
  const [
    "꦳",
    "ꦀ",
    "ꦁ",
    "ꦂ",
    "ꦃ",
    "ꦿ",
    "ꦽ",
    "ꦁ",
    "꧇",
    "꧇",
  ],
  const [
    "ꦼ",
    "ꦮ",
    "ꦺ",
    "ꦫ",
    "ꦠ",
    "ꦪ",
    "ꦸ",
    "ꦶ",
    "ꦺꦴ",
    "ꦥ",
  ],
  const [
    "꧀",
    "ꦱ",
    "ꦢ",
    "ꦉ",
    "ꦒ",
    "ꦲ",
    "ꦗ",
    "ꦏ",
    "ꦭ",
    "ꦝ",
  ],
  const [
    KeyAction.SwitchShift,
    "ꦚ",
    "ꦔ",
    "ꦕ",
    "ꦊ",
    "ꦧ",
    "ꦤ",
    "ꦩ",
    "ꦛ",
    KeyAction.Backspace,
  ],
  const [
    KeyAction.SwitchNumber,
    "꧊",
    KeyAction.Space,
    "꧋",
    KeyAction.Enter,
  ],
];

const List<List> _shiftKeyboardLayout = [
  const [
    "ꦴ",
    "ꦷ",
    "ꦹ",
    "ꦵ",
    "꧁",
    "꧂",
    "꧃",
    "꧄",
    "꧅",
    " ",
  ],
  const [
    "ꦐ",
    "ꦻ",
    "ꦌ",
    "ꦍ",
    "ꦡ",
    "ꦅ",
    "ꦈ",
    "ꦆ",
    "ꦎ",
    "ꦦ",
  ],
  const [
    "ꦄ",
    "ꦯ",
    "ꦣ",
    "ꦬ",
    "ꦓ",
    "ꦙ",
    "ꦘ",
    "ꦑ",
    "ꦇ",
    "ꦞ",
  ],
  const [
    KeyAction.SwitchMain,
    "꧌",
    "꧍",
    "ꦖ",
    "ꦋ",
    "ꦨ",
    "ꦟ",
    "ꦰ",
    "ꦜ",
    KeyAction.Backspace,
  ],
  const [
    KeyAction.SwitchNumber,
    "꧊",
    KeyAction.Space,
    "꧋",
    KeyAction.Enter,
  ],
];

const List<List> _numberKeyboardLayout = [
  const [
    "꧑",
    "꧒",
    "꧓",
    "꧔",
    "꧕",
    "꧖",
    "꧗",
    "꧘",
    "꧙",
    "꧐",
  ],
  const [
    "@",
    "#",
    "\$",
    "%",
    "^",
    "&",
    "*",
    "(",
    ")",
    "=",
  ],
  const [
    "+",
    "-",
    "×",
    "÷",
    "<",
    ">",
    "{",
    "}",
    "[",
    "]",
  ],
  const [
    KeyAction.SwitchShift,
    "_",
    "‘",
    "“”",
    "~",
    "|",
    "\\",
    "꧞",
    "꧟",
    KeyAction.Backspace,
  ],
  const [
    KeyAction.SwitchNumber,
    "!",
    KeyAction.Space,
    "?",
    KeyAction.Enter,
  ],
];
