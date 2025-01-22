part of in_app_keyboard;

/// The default keyboard height. Can we overriden by passing
///  `height` argument to `VirtualKeyboard` widget.
const double _keyboardDefaultHeight = 300;

const int _keyboardBackspaceEventPerioud = 100;

/// Virtual Keyboard widget.
class Keyboard extends StatefulWidget {
  /// Keyboard Type: Should be inited in creation time.
  final KeyboardType type;

  /// Callback for Key press event. Called with pressed `Key` object.
  final Function? onKeyPress;

  /// Virtual keyboard height. Default is 300
  final double height;

  /// Virtual keyboard height. Default is full screen width
  final double? width;

  /// Color for key texts and icons.
  final Color textColor;

  /// Font size for keyboard keys.
  final double fontSize;

  /// the custom layout for multi or single language
  final KeyboardLayoutKeys? customLayoutKeys;

  /// the text controller go get the output and send the default input
  final TextEditingController? textController;

  /// The builder function will be called for each Key object.
  final Widget Function(BuildContext context, KeyboardKey key)? builder;

  /// Set to true if you want only to show Caps letters.
  final bool alwaysCaps;

  /// inverse the layout to fix the issues with right to left languages.
  final bool reverseLayout;

  /// used for multi-languages with default layouts, the default is English only
  /// will be ignored if customLayoutKeys is not null
  final List<KeyboardDefaultLayouts>? defaultLayouts;

  Keyboard(
      {Key? key,
      required this.type,
      this.onKeyPress,
      this.builder,
      this.width,
      this.defaultLayouts,
      this.customLayoutKeys,
      this.textController,
      this.reverseLayout = false,
      this.height = _keyboardDefaultHeight,
      this.textColor = Colors.black,
      this.fontSize = 14,
      this.alwaysCaps = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeyboardState();
  }
}

/// Holds the state for Virtual Keyboard class.
class _KeyboardState extends State<Keyboard> {
  late KeyboardType type;
  Function? onKeyPress;
  late TextEditingController textController;
  // The builder function will be called for each Key object.
  Widget Function(BuildContext context, KeyboardKey key)? builder;
  late double height;
  double? width;
  late Color textColor;
  late double fontSize;
  late bool alwaysCaps;
  late bool reverseLayout;
  late KeyboardLayoutKeys customLayoutKeys;
  // Text Style for keys.
  late TextStyle textStyle;

  // True if shift is enabled.
  bool isShiftEnabled = false;

  void _onKeyPress(KeyboardKey key) {
    var cursorPos = textController.selection.base.offset;
    if (key.keyType == KeyboardKeyType.String) {
      textController.text = textController.text.substring(0, cursorPos) +
          ((isShiftEnabled ? key.capsText : key.text) ?? '') +
          textController.text.substring(cursorPos);
      // set cursor position
      textController.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos + 1));
    } else if (key.keyType == KeyboardKeyType.Action) {
      switch (key.action) {
        case KeyAction.Backspace:
          if (textController.text.length == 0) return;
          textController.text =
              textController.text.substring(0, cursorPos - 1) +
                  textController.text.substring(cursorPos);
          // set cursor position
          textController.selection =
              TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));
          break;
        case KeyAction.Return:
          textController.text += '\n';
          break;
        case KeyAction.Space:
          textController.text += (key.text ?? '');
          break;
        case KeyAction.Shift:
          break;
        default:
      }
    }

    onKeyPress?.call(key);
  }

  @override
  dispose() {
    if (widget.textController == null) // dispose if created locally only
      textController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Keyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      type = widget.type;
      builder = widget.builder;
      onKeyPress = widget.onKeyPress;
      height = widget.height;
      width = widget.width;
      textColor = widget.textColor;
      fontSize = widget.fontSize;
      alwaysCaps = widget.alwaysCaps;
      reverseLayout = widget.reverseLayout;
      textController = widget.textController ?? textController;
      customLayoutKeys = widget.customLayoutKeys ?? customLayoutKeys;
      // Init the Text Style for keys.
      textStyle = TextStyle(
        fontSize: fontSize,
        color: textColor,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    textController = widget.textController ?? TextEditingController();
    width = widget.width;
    type = widget.type;
    customLayoutKeys = widget.customLayoutKeys ??
        KeyboardDefaultLayoutKeys(
            widget.defaultLayouts ?? [KeyboardDefaultLayouts.English]);
    builder = widget.builder;
    onKeyPress = widget.onKeyPress;
    height = widget.height;
    textColor = widget.textColor;
    fontSize = widget.fontSize;
    alwaysCaps = widget.alwaysCaps;
    reverseLayout = widget.reverseLayout;
    // Init the Text Style for keys.
    textStyle = TextStyle(
      fontSize: fontSize,
      color: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return type == KeyboardType.Numeric ? _numeric() : _alphanumeric();
  }

  Widget _alphanumeric() {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(),
      ),
    );
  }

  Widget _numeric() {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(),
      ),
    );
  }

  /// Returns the rows for keyboard.
  List<Widget> _rows() {
    // Get the keyboard Rows
    List<List<KeyboardKey>> keyboardRows = type == KeyboardType.Numeric
        ? _getKeyboardRowsNumeric()
        : _getKeyboardRows(customLayoutKeys);

    // Generate keyboard row.
    List<Widget> rows = List.generate(keyboardRows.length, (int rowNum) {
      var items = List.generate(keyboardRows[rowNum].length, (int keyNum) {
        // Get the VirtualKeyboardKey object.
        KeyboardKey keyboardKey = keyboardRows[rowNum][keyNum];

        Widget keyWidget;

        // Check if builder is specified.
        // Call builder function if specified or use default
        //  Key widgets if not.
        if (builder == null) {
          // Check the key type.
          switch (keyboardKey.keyType) {
            case KeyboardKeyType.String:
              // Draw String key.
              keyWidget = _keyboardDefaultKey(keyboardKey);
              break;
            case KeyboardKeyType.Action:
              // Draw action key.
              keyWidget = _keyboardDefaultActionKey(keyboardKey);
              break;
          }
        } else {
          // Call the builder function, so the user can specify custom UI for keys.
          keyWidget = builder!(context, keyboardKey);

          // if (keyWidget == null) {
          //   throw 'builder function must return Widget';
          // }
        }

        return keyWidget;
      });

      if (this.reverseLayout) items = items.reversed.toList();
      return Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Generate keboard keys
          children: items,
        ),
      );
    });

    return rows;
  }

  // True if long press is enabled.
  bool longPress = false;

  /// Creates default UI element for keyboard Key.
  Widget _keyboardDefaultKey(KeyboardKey key) {
    return Expanded(
        child: InkWell(
      onTap: () {
        _onKeyPress(key);
      },
      child: Container(
        height: height / customLayoutKeys.activeLayout.length,
        child: Center(
            child: Text(
          alwaysCaps
              ? key.capsText ?? ''
              : (isShiftEnabled ? key.capsText : key.text) ?? '',
          style: textStyle,
        )),
      ),
    ));
  }

  /// Creates default UI element for keyboard Action Key.
  Widget _keyboardDefaultActionKey(KeyboardKey key) {
    // Holds the action key widget.
    Widget? actionKey;

    // Switch the action type to build action Key widget.
    switch (key.action ?? KeyAction.SwithLanguage) {
      case KeyAction.Backspace:
        actionKey = GestureDetector(
            onLongPress: () {
              longPress = true;
              // Start sending backspace key events while longPress is true
              Timer.periodic(
                  Duration(milliseconds: _keyboardBackspaceEventPerioud),
                  (timer) {
                if (longPress) {
                  _onKeyPress(key);
                } else {
                  // Cancel timer.
                  timer.cancel();
                }
              });
            },
            onLongPressUp: () {
              // Cancel event loop
              longPress = false;
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Icon(
                Icons.backspace,
                color: textColor,
              ),
            ));
        break;
      case KeyAction.Shift:
        actionKey = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Shift', style: TextStyle(fontSize: 12)),
            SizedBox(width: 5),
            Icon(
              isShiftEnabled ? Icons.arrow_downward : Icons.arrow_upward,
              color: textColor,
              size: 18,
            ),
          ],
        );
        break;
      case KeyAction.Space:
        actionKey = actionKey = Icon(Icons.space_bar, color: textColor);
        break;
      case KeyAction.Return:
        actionKey = Icon(
          Icons.keyboard_return,
          color: textColor,
        );
        break;
      case KeyAction.SwithLanguage:
        actionKey = GestureDetector(
            onTap: () {
              setState(() {
                customLayoutKeys.switchLanguage();
              });
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Icon(
                Icons.language,
                color: textColor,
              ),
            ));
        break;

      case KeyAction.Confirm:
        actionKey = Icon(
          Icons.check_circle_rounded,
          color: textColor,
        );
        break;
    }

    var wdgt = InkWell(
      onTap: () {
        if (key.action == KeyAction.Shift) {
          if (!alwaysCaps) {
            setState(() {
              isShiftEnabled = !isShiftEnabled;
            });
          }
        }

        _onKeyPress(key);
      },
      child: Container(
        alignment: Alignment.center,
        height: height / customLayoutKeys.activeLayout.length,
        child: actionKey,
      ),
    );

    if (key.action == KeyAction.Space)
      return Expanded(flex: 5, child: wdgt);
    else if (key.action == KeyAction.Confirm ||
        key.action == KeyAction.Shift ||
        key.action == KeyAction.Backspace)
      return Expanded(flex: 2, child: wdgt);
    else
      return Expanded(child: wdgt);
  }
}
