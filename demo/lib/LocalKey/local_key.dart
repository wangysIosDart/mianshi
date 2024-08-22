

import 'dart:math';

import 'package:flutter/material.dart';


///https://www.jianshu.com/p/1bb134d381b3
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalKey',
      theme: ThemeData(primarySwatch: Colors.blue), // 设置主题颜色
      home: StateKeyDemo(), // 指定主页
    );
  }
}

class StateKeyDemo extends StatefulWidget {
  const StateKeyDemo({Key? key}) : super(key: key);

  @override
  _StateKeyDemoState createState() => _StateKeyDemoState();
}

class _StateKeyDemoState extends State<StateKeyDemo> {
  /// 由于重用机制 都没有正确删除
  // List<Widget> items = [
  //   const statefulItem(
  //     title: '111',
  //   ),
  //   const statefulItem(
  //     title: '222',
  //   ),
  //   const statefulItem(
  //     title: '333',
  //   )
  // ];

  ///增加key才有效
  List<Widget> items = [
    const statefulItem(
      title: '111',
      key: ValueKey(111),
    ),
    const statefulItem(
      title: '222',
      key: ValueKey(222),
    ),
    const statefulItem(
      title: '333',
      key: ValueKey(333),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('demoStl'), backgroundColor: Colors.blue),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            items.removeAt(0);
          });
        },
      ),
    );
  }
}

class statefulItem extends StatefulWidget {
  final String? title;
  const statefulItem({this.title, Key? key}) : super(key: key);

  @override
  _statefulItemState createState() => _statefulItemState();
}

class _statefulItemState extends State<statefulItem> {
  final color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
      child: Text(widget.title!),
    );
  }
}