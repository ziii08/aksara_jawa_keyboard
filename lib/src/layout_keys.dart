part of virtual_keyboard_multi_language;
//import '../virtual_keyboard_multi_language.dart';

class VirtualKeyboardLayoutKeys{

  int getLanguagesCount() => 1;

  int activeIndex =0;

  List<List> getLanguage(int index){
    return _defaultEnglishLayout;
  }

  void switchLanguage(){
    if((activeIndex+1) == getLanguagesCount())
      activeIndex =0;
    else activeIndex++;
  }

  List<List> get defaultEnglishLayout => _defaultEnglishLayout;

  List<List> get activeLayout =>  getLanguage(activeIndex);

}

  /// Keys for Virtual Keyboard's rows.
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
    VirtualKeyboardKeyAction.Backspace
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
    ';',
    '\'',
    VirtualKeyboardKeyAction.Return
  ],
  // Row 4
  const [
    VirtualKeyboardKeyAction.Shift,
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
    VirtualKeyboardKeyAction.Shift
  ],
  // Row 5
  const [
    VirtualKeyboardKeyAction.SwithLanguage,
    '@',
    VirtualKeyboardKeyAction.Space,
    '&',
    '_',
  ]
];
