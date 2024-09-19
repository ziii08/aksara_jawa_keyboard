part of virtual_keyboard_multi_language;

class AppKeyboard extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final List<TextEditingController> textControllers;
  final List<VirtualKeyboardType> keyboardTypes;
  final Duration showDuration;
  final Color foregroundColor;
  final Color backgroundColor;
  final double fontSize;
  final double height;

  AppKeyboard({
    Key? key,
    required this.focusNodes,
    required this.textControllers,
    required this.keyboardTypes,
    this.showDuration = const Duration(milliseconds: 250),
    this.foregroundColor = Colors.black,
    this.backgroundColor = const Color(0xFFe3f2fd),
    this.fontSize = 20,
    this.height = 250,
  });

  @override
  _AppKeyboardState createState() => _AppKeyboardState();
}

class _AppKeyboardState extends State<AppKeyboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool shiftEnabled = false;
  bool isNumericMode = false;
  bool isShow = false;
  double height = 0;

  late FocusNode currentFocus;
  late TextEditingController currentTextController;
  late VirtualKeyboardType currentKeyboardType;

  @override
  void initState() {
    super.initState();

    widget.focusNodes.map((e) {
      e.addListener(() {
        if (e.hasFocus) {
          isShow = true;
          height = widget.height;
          currentFocus = e;
          currentTextController =
              widget.textControllers[widget.focusNodes.indexOf(e)];
          currentKeyboardType =
              widget.keyboardTypes[widget.focusNodes.indexOf(e)];
          setState(() {});
        }
      });
    }).toList();
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    isShow = false;
    height = 0;

    _controller.dispose();
    widget.focusNodes.map((e) {
      e.dispose();
    }).toList();
    widget.textControllers.map((e) {
      e.dispose();
    }).toList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.showDuration,
      alignment: Alignment.topCenter,
      child: Container(
        height: height,
        color: widget.backgroundColor,
        child: !isShow
            ? null
            : VirtualKeyboard(
                height: widget.height,
                fontSize: widget.fontSize,
                textColor: widget.foregroundColor,
                textController: currentTextController,
                defaultLayouts: [
                  VirtualKeyboardDefaultLayouts.Colposcopy,
                ],
                type: currentKeyboardType,
                onKeyPress: _onKeyPress,
              ),
      ),
    );
  }

  _onKeyPress(VirtualKeyboardKey key) {
    currentFocus.requestFocus();
    if (key.keyType != VirtualKeyboardKeyType.Action) return;
    if (key.action != VirtualKeyboardKeyAction.Confirm) return;
    FocusScope.of(context).unfocus();
    isShow = false;
    height = 0;
    setState(() {});
  }
}
