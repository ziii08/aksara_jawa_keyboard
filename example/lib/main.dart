import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Keyboard Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Virtual Keyboard Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerText1 = TextEditingController();
  final _controllerText2 = TextEditingController();
  final _controllerText3 = TextEditingController();

  // AppKeyboard States
  List<FocusNode> focusNodes = List.generate(2, (index) => FocusNode());
  TextEditingController _keyboardTextController = TextEditingController();
  VirtualKeyboardType _keyboardType = VirtualKeyboardType.Alphanumeric;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              focusNode: focusNodes[0],
              controller: _controllerText1,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                labelText: 'This is Number',
              ),
              onTap: () {
                log('Field with focus1 tapped');
                _keyboardTextController = _controllerText1;
                _keyboardType = VirtualKeyboardType.Numeric;
                setState(() {});
              },
            ),
            TextFormField(
              focusNode: focusNodes[1],
              controller: _controllerText2,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                labelText: 'This is AlphaNumeric',
              ),
              onTap: () {
                log('Field with focus2 tapped');
                _keyboardTextController = _controllerText2;
                _keyboardType = VirtualKeyboardType.Alphanumeric;
                setState(() {});
              },
            ),
            TextFormField(
              controller: _controllerText3,
              decoration: InputDecoration(
                labelText: 'Field wihout focus',
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Text('Tap on the text fields to show the keyboard'),
            AppKeyboard(
              focusNodes: focusNodes,
              textController: _keyboardTextController,
              keyboardType: _keyboardType,
            ),
          ],
        ),
      ),
    );
  }
}
