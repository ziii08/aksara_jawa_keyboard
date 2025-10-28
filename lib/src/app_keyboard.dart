part of aksara_jawa_keyboard;

class AppKeyboard extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final List<TextEditingController> textControllers;
  final Duration showDuration;
  final Color foregroundColor;
  final Color backgroundColor;
  final double fontSize;
  final double height;
  final void Function(bool isShow) onShow;

  const AppKeyboard({
    super.key,
    required this.focusNodes,
    required this.textControllers,
    this.showDuration = const Duration(milliseconds: 250),
    this.foregroundColor = Colors.black,
    this.backgroundColor = const Color(0xFFd1d4d9),
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

  FocusNode? currentFocus;
  TextEditingController? currentTextController;

  final Map<FocusNode, VoidCallback> _listeners = {};
  Timer? _blurTimer;

  @override
  void initState() {
    super.initState();

    for (final e in widget.focusNodes) {
      final listener = () {
        if (e.hasFocus) {
          // cancel any pending blur
          _blurTimer?.cancel();

          isShow = true;
          widget.onShow(isShow);
          height = widget.height;
          currentFocus = e;
          final idx = widget.focusNodes.indexOf(e);
          if (idx >= 0 && idx < widget.textControllers.length) {
            currentTextController = widget.textControllers[idx];
          }

          if (mounted) setState(() {});
        } else {
          // schedule cancelable blur
          _blurTimer?.cancel();
          _blurTimer = Timer(const Duration(milliseconds: 100), () {
            if (!mounted) return;
            if (currentFocus?.hasFocus == true || isMaintainKeyboard) return;
            closeKeyboard();
          });
        }
      };

      e.addListener(listener);
      _listeners[e] = listener;
    }
  }

  @override
  void dispose() {
    // cancel any pending delayed tasks
    _blurTimer?.cancel();
    _blurTimer = null;

    // remove all listeners
    for (final e in widget.focusNodes) {
      final l = _listeners[e];
      if (l != null) e.removeListener(l);
    }
    _listeners.clear();

    isShow = false;
    widget.onShow(isShow);
    height = 0;
    super.dispose();
  }

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    isShow = false;
    widget.onShow(isShow);
    height = 0;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => isMaintainKeyboard = true,
      onTapUp: (_) => isMaintainKeyboard = false,   // reset correctly
      onTapCancel: () => isMaintainKeyboard = false,
      child: AnimatedSize(
        duration: widget.showDuration,
        alignment: Alignment.topCenter,
        child: ColoredBox(
          color: widget.backgroundColor,
          child: !isShow || currentTextController == null
              ? null
              : Keyboard(
                  height: widget.height,
                  fontSize: widget.fontSize,
                  textColor: widget.foregroundColor,
                  textController: currentTextController!,
                  onKeyPress: _onKeyPress,
                ),
        ),
      ),
    );
  }

  void _onKeyPress(KeyboardKey key) {
    currentFocus?.requestFocus();
    if (key.keyType != KeyboardKeyType.Action) return;
    if (key.action != KeyAction.Confirm) return;
    closeKeyboard();
  }
}
