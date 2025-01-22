part of in_app_keyboard;

abstract class KeyboardLayoutKeys {
  int activeIndex = 0;

  List<List> get defaultEnglishLayout => _defaultEnglishLayout;
  List<List> get defaultArabicLayout => _defaultArabicLayout;

  List<List> get activeLayout => getLanguage(activeIndex);
  int getLanguagesCount();
  List<List> getLanguage(int index);

  void switchLanguage() {
    if ((activeIndex + 1) == getLanguagesCount())
      activeIndex = 0;
    else
      activeIndex++;
  }
}

class KeyboardDefaultLayoutKeys extends KeyboardLayoutKeys {
  List<KeyboardDefaultLayouts> defaultLayouts;
  KeyboardDefaultLayoutKeys(this.defaultLayouts);

  int getLanguagesCount() => defaultLayouts.length;

  List<List> getLanguage(int index) {
    switch (defaultLayouts[index]) {
      case KeyboardDefaultLayouts.English:
        return _defaultEnglishLayout;
      case KeyboardDefaultLayouts.Arabic:
        return _defaultArabicLayout;
      default:
    }
    return _defaultEnglishLayout;
  }
}

const List<List> _defaultEnglishLayout = [
  // Row 1
  const [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
  ],
  // Row 2
  const [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
  ],
  // Row 3
  const [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
    // ';',
    // '\'',
    KeyAction.Backspace
  ],
  // Row 4
  const [
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
    ',',
    '.',
    '/',
    KeyAction.Shift,
  ],
  // Row 5
  const [
    KeyAction.SwithLanguage,
    '@',
    KeyAction.Space,
    '&',
    '_',
    '-',
    KeyAction.Confirm,
  ]
];

const List<List> _defaultArabicLayout = [
  // Row 1
  const [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
  ],
  // Row 2
  const [
    'ض',
    'ص',
    'ث',
    'ق',
    'ف',
    'غ',
    'ع',
    'ه',
    'خ',
    'ح',
    'ج',
    'د',
    KeyAction.Backspace
  ],
  // Row 3
  const [
    'ش',
    'س',
    'ي',
    'ب',
    'ل',
    'ا',
    'ت',
    'ن',
    'م',
    'ك',
    'ط',
    KeyAction.Return
  ],
  // Row 4
  const [
    'ذ',
    'ئ',
    'ء',
    'ؤ',
    'ر',
    'لا',
    'ى',
    'ة',
    'و',
    'ز',
    'ظ',
    KeyAction.Shift
  ],
  // Row 5
  const [
    KeyAction.SwithLanguage,
    '@',
    KeyAction.Space,
    '-',
    '.',
    '_',
  ]
];
