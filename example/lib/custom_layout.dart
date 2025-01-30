import 'package:in_app_keyboard/in_app_keyboard.dart';

class CustomLayoutKeys extends KeyboardLayoutKeys {
  @override
  int getLanguagesCount() => 2;

  List<List> getLanguage(int index) {
    switch (index) {
      case 1:
        return _arabicLayout;
      default:
        return defaultEnglishLayout;
    }
  }

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
}

const List<List> _arabicLayout = [
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
    '.',
    'ظ',
    KeyAction.Shift
  ],
  // Row 5
  const [
    KeyAction.SwitchLanguage,
    '@',
    KeyAction.Space,
    '-',
    '_',
  ]
];
