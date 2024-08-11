import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _inputController = TextEditingController();
  String _keywords = "Initial text"; // 你想设置的初始值

  @override
  void initState() {
    super.initState();
    // 设置 TextEditingController 的初始值
    _inputController.text = _keywords; // 直接赋值
  }

  @override
  void dispose() {
    _inputController.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _inputController, // 确保绑定
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyWidget(), // 确保从这里启动
  ));
}