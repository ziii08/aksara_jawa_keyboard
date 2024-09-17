part of virtual_keyboard_multi_language;

class AppKeyboard extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final TextEditingController textController;
  final VirtualKeyboardType keyboardType;
  final Color foregroundColor;
  final Color backgroundColor;

  AppKeyboard({
    Key? key,
    required this.focusNodes,
    required this.textController,
    this.keyboardType = VirtualKeyboardType.Numeric,
    this.foregroundColor = Colors.black,
    this.backgroundColor = const Color(0xFFe3f2fd),
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

  @override
  void initState() {
    super.initState();
    widget.focusNodes.map((e) {
      e.addListener(() {
        if (e.hasFocus) {
          isShow = true;
          height = 250;
          setState(() {});
        } else {
          isShow = false;
          height = 0;
          setState(() {});
        }
      });
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      alignment: Alignment.topCenter,
      child: Container(
        height: height,
        color: widget.backgroundColor,
        child: !isShow
            ? null
            : VirtualKeyboard(
                height: 250,
                textColor: widget.foregroundColor,
                textController: widget.textController,
                defaultLayouts: [
                  VirtualKeyboardDefaultLayouts.Colposcopy,
                ],
                type: widget.keyboardType,
                onKeyPress: _onKeyPress,
              ),
      ),
    );
  }

  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType != VirtualKeyboardKeyType.Action) return;
    if (key.action != VirtualKeyboardKeyAction.Confirm) return;
    FocusScope.of(context).unfocus();
    setState(() {});
  }
}
