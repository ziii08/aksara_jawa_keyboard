part of in_app_keyboard;

class AppKeyboard extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final List<TextEditingController> textControllers;
  final List<KeyboardType> keyboardTypes;
  final List<KeyboardDefaultLayouts> defaultLayouts;
  final Duration showDuration;
  final Color foregroundColor;
  final Color backgroundColor;
  final double fontSize;
  final double height;
  final void Function(bool isShow) onShow;

  AppKeyboard({
    Key? key,
    required this.focusNodes,
    required this.textControllers,
    required this.keyboardTypes,
    this.defaultLayouts = const [
      KeyboardDefaultLayouts.English,
      KeyboardDefaultLayouts.Arabic,
    ],
    this.showDuration = const Duration(milliseconds: 250),
    this.foregroundColor = Colors.black,
    this.backgroundColor = const Color(0xFFe3f2fd),
    this.fontSize = 20,
    this.height = 250,
    required this.onShow,
  });

  @override
  _AppKeyboardState createState() => _AppKeyboardState();
}

class _AppKeyboardState extends State<AppKeyboard> {
  bool shiftEnabled = false;
  bool isNumericMode = false;
  bool isShow = false;
  double height = 0;
  bool isMaintainKeyboard = false;

  late FocusNode currentFocus;
  late TextEditingController currentTextController;
  late KeyboardType currentKeyboardType;

  @override
  void initState() {
    super.initState();

    widget.focusNodes.map((e) {
      e.addListener(() async {
        if (e.hasFocus) {
          isShow = true;
          widget.onShow(isShow);
          height = widget.height;
          currentFocus = e;
          currentTextController =
              widget.textControllers[widget.focusNodes.indexOf(e)];
          currentKeyboardType =
              widget.keyboardTypes[widget.focusNodes.indexOf(e)];
          setState(() {});
        } else {
          await Future.delayed(Duration(milliseconds: 100));
          if (currentFocus.hasFocus || isMaintainKeyboard) return;
          closeKeyboard();
        }
      });
    }).toList();
  }

  @override
  void dispose() {
    isShow = false;
    widget.onShow(isShow);
    height = 0;
    super.dispose();
  }

  void closeKeyboard() {
    FocusScope.of(context).unfocus();
    isShow = false;
    widget.onShow(isShow);
    height = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => isMaintainKeyboard = true,
      onTapCancel: () => isMaintainKeyboard = false,
      child: AnimatedSize(
        duration: widget.showDuration,
        alignment: Alignment.topCenter,
        child: Container(
          height: height,
          color: widget.backgroundColor,
          child: !isShow
              ? null
              : Keyboard(
                  height: widget.height,
                  fontSize: widget.fontSize,
                  textColor: widget.foregroundColor,
                  textController: currentTextController,
                  defaultLayouts: widget.defaultLayouts,
                  type: currentKeyboardType,
                  onKeyPress: _onKeyPress,
                ),
        ),
      ),
    );
  }

  _onKeyPress(KeyboardKey key) {
    currentFocus.requestFocus();
    if (key.keyType != KeyboardKeyType.Action) return;
    if (key.action != KeyAction.Confirm) return;
    closeKeyboard();
  }
}
