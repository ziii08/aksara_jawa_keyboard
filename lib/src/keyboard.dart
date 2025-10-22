part of aksara_jawa_keyboard;

/// The default keyboard height. Can we overriden by passing
///  `height` argument to `VirtualKeyboard` widget.
const double _keyboardDefaultHeight = 300;

const int _keyboardBackspaceEventPerioud = 100;

/// Virtual Keyboard widget.
class Keyboard extends StatefulWidget {
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

  /// inverse the layout to fix the issues with right to left languages.
  final bool reverseLayout;

  /// used for multi-languages with default layouts, the default is English only
  /// will be ignored if customLayoutKeys is not null

  final bool shadow;

  Keyboard(
      {Key? key,
      this.onKeyPress,
      this.builder,
      this.width,
      this.customLayoutKeys,
      this.textController,
      this.reverseLayout = false,
      this.height = _keyboardDefaultHeight,
      this.textColor = Colors.black,
      this.fontSize = 14,
      this.shadow = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeyboardState();
  }
}

/// Holds the state for Virtual Keyboard class.
class _KeyboardState extends State<Keyboard> {
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
  KeyboardLayoutKeys customLayoutKeys = AksaraJawaKeyboard();
  // Text Style for keys.
  late TextStyle textStyle;

  void _onKeyPress(KeyboardKey key) {
    var cursorPos = textController.selection.base.offset;
    // Jika posisi kursor tidak valid, atur kursor ke akhir teks.
    if (cursorPos < 0) {
      cursorPos = textController.text.length;
    }

    if (key.keyType == KeyboardKeyType.String) {
      textController.text = textController.text.substring(0, cursorPos) +
          ((key.text) ?? '') +
          textController.text.substring(cursorPos);
      // set cursor position
      textController.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos + 1));
    } else if (key.keyType == KeyboardKeyType.Action) {
      switch (key.action) {
        case KeyAction.Backspace:
          if (textController.text.isNotEmpty && cursorPos > 0) {
            // Periksa apakah hanya ada satu karakter atau kursor ada di posisi pertama.
            textController.text =
                textController.text.substring(0, cursorPos - 1) +
                    textController.text.substring(cursorPos);
            // set cursor position
            textController.selection =
                TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));
          }

          break;
        case KeyAction.Space:
          textController.text += (key.text ?? '');
          break;
        case KeyAction.Enter:
          textController.text += '\n';
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
      builder = widget.builder;
      onKeyPress = widget.onKeyPress;
      height = widget.height;
      width = widget.width;
      textColor = widget.textColor;
      fontSize = widget.fontSize;
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
    builder = widget.builder;
    onKeyPress = widget.onKeyPress;
    height = widget.height;
    textColor = widget.textColor;
    fontSize = widget.fontSize;
    reverseLayout = widget.reverseLayout;
    // Init the Text Style for keys.
    textStyle = TextStyle(
      fontSize: fontSize,
      color: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _alphanumeric();
  }

  Widget _alphanumeric() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 20, bottom: 12),
        child: SizedBox(
          height: height,
          width: width ?? MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _rows(),
          ),
        ),
      ),
    );
  }

  /// Returns the rows for keyboard.
  List<Widget> _rows() {
    // Get the keyboard Rows
    List<List<KeyboardKey>> keyboardRows = _getKeyboardRows(customLayoutKeys);

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
          mainAxisAlignment: MainAxisAlignment.center,
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
    return SizedBox(
        width: MediaQuery.of(context).size.width /
            customLayoutKeys.activeLayout[0].length,
        height: height / customLayoutKeys.activeLayout.length,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: InkWell(
            onTap: () {
              _onKeyPress(key);
            },
            child: CustomContainer(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                child: Text(
                  key.text ?? '',
                  style: textStyle.copyWith(
                      fontFamily: 'nyk Ngayogyan New',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ));
  }

  /// Creates default UI element for keyboard Action Key.
  Widget _keyboardDefaultActionKey(KeyboardKey key) {
    // Holds the action key widget.
    Widget? actionKey;

    // Switch the action type to build action Key widget.
    switch (key.action ?? KeyAction.SwitchMain) {
      case KeyAction.Backspace:
        actionKey = Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: GestureDetector(
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
              child: CustomContainer(
                color: Color(0xFFB5B5B5),
                child: Icon(
                  Icons.backspace_outlined,
                  color: textColor,
                ),
              )),
        );
        break;
      case KeyAction.SwitchShift || KeyAction.SwitchMain:
        actionKey = Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (key.action == KeyAction.SwitchMain) {
                  customLayoutKeys.switchMain();
                } else {
                  customLayoutKeys.switchShift();
                }
              });
            },
            child: CustomContainer(
              color: Color(0xFFB5B5B5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: textColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case KeyAction.Space:
        actionKey = actionKey = Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: CustomContainer(
            color: Colors.white,
            child: Text(
              "Spasi",
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        );
        break;

      case KeyAction.Confirm:
        actionKey = Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: CustomContainer(
            color: Color(0xFFB5B5B5),
            child: Icon(
              Icons.check_circle_rounded,
              color: textColor,
            ),
          ),
        );
        break;

      case KeyAction.SwitchNumber:
        actionKey = Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  customLayoutKeys.switchNumber();
                });
              },
              child: CustomContainer(
                color: Color(0xFFB5B5B5),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text('123',
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.bold, height: 1)),
                ),
              )),
        );
        break;
      case KeyAction.Enter:
        actionKey = Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: CustomContainer(
            color: Color(0xFFB5B5B5),
            child: Icon(
              Icons.keyboard_return,
              color: textColor,
            ),
          ),
        );
        break;
    }

    var wdgt = InkWell(
      onTap: () {
        _onKeyPress(key);
      },
      child: SizedBox(
        height: height / customLayoutKeys.activeLayout.length,
        child: actionKey,
      ),
    );

    if (key.action == KeyAction.Space)
      return Expanded(flex: 5, child: wdgt);
    else if (key.action == KeyAction.SwitchNumber ||
        key.action == KeyAction.Enter) {
      return Expanded(flex: 2, child: wdgt);
    } else if (key.action == KeyAction.Confirm ||
        key.action == KeyAction.SwitchShift ||
        key.action == KeyAction.Backspace)
      return Expanded(child: wdgt);
    else
      return Expanded(child: wdgt);
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color = Colors.white,
    this.alignment = Alignment.center,
    required this.child,
  });

  final double? width;
  final double? height;
  final double? radius;
  final Color color;
  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: CustomRounded(radius: radius ?? 5),
        child: ColoredBox(
            color: color,
            child: SizedBox(
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              child: Align(alignment: alignment, child: child),
            )));
  }
}

class CustomRounded extends CustomClipper<Path> {
  CustomRounded({this.radius = 5});

  final double radius;

  @override
  Path getClip(Size s) {
    final topRect = Rect.fromLTWH(0, 0, s.width, (2 * radius).toDouble());
    final bottomRect = Rect.fromLTWH(
        0, s.height - 2 * radius, s.width, (2 * radius).toDouble());

    final p = Path()
      ..moveTo(0, radius.toDouble())
      ..lineTo(0, s.height - radius)
      ..arcTo(bottomRect, math.pi, -math.pi,
          false)
      ..lineTo(s.width, radius.toDouble())
      ..arcTo(topRect, 0, -math.pi, false)
      ..close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
