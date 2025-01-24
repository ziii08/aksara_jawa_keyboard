part of in_app_keyboard;

abstract class KeyboardLayoutKeys {
  int activeIndex = 1;
  KeyboardLayoutType layoutType = KeyboardLayoutType.Alphabetic;

  List<List> get defaultEnglishLayout => _defaultEnglishLayout;
  List<List> get defaultArabicLayout => _defaultArabicLayout;
  List<List> get defaultNumericLayout => _defaultNumericLayout;

  List<List> get activeLayout => getLayout(layoutType, activeIndex);
  int getLanguagesCount();
  List<List> getLanguage(int index);
  List<List> getLayout(KeyboardLayoutType layout, int index);

  void switchNumeric() {
    layoutType = KeyboardLayoutType.Numeric;
  }

  void switchAlphabetic() {
    layoutType = KeyboardLayoutType.Alphabetic;
  }

  void switchLanguage() {
    if ((activeIndex + 1) == getLanguagesCount()) {
      activeIndex = 0;
    } else {
      activeIndex++;
    }
    log('activeIndex: $activeIndex');
  }
}

class KeyboardDefaultLayoutKeys extends KeyboardLayoutKeys {
  List<KeyboardDefaultLayouts> defaultLayouts;
  KeyboardDefaultLayoutKeys(this.defaultLayouts);

  @override
  int getLanguagesCount() => defaultLayouts.length;


  @override
  List<List> getLayout(KeyboardLayoutType layout, int index) {
    switch (layout) {
      case KeyboardLayoutType.Numeric:
        return defaultNumericLayout;
      case KeyboardLayoutType.Special:
        return [];
      default:
        return getLanguage(index);
    }
  }

  @override
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
  ],
  // Row 4
  const [
    KeyAction.Shift,
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
    KeyAction.Backspace
    // ',',
    // '.',
    // '/',
  ],
  // Row 5
  const [
    KeyAction.SwithNumeric,
    '/',
    KeyAction.SwithLanguage,
    KeyAction.Space,
    // '&',
    // '_',
    // '-',
    '.',
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

const List<List> _defaultNumericLayout = [
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
    '@',
    '#',
    '\$',
    '_',
    '&',
    '-',
    '+',
    '(',
    ')',
    '/',
  ],

  // Row 3
  const [
    KeyAction.SwitchSpecial,
    '*',
    '"',
    '\'',
    ':',
    ';',
    '!',
    '?',
    KeyAction.Backspace,
  ],

  // Row 4
  const [
    KeyAction.SwitchAlphabetic,
    ',',
    '12\n34',
    KeyAction.Space,
    '.',
    KeyAction.Confirm,
  ]
];
