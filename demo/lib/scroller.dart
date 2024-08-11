import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyScrollWidget',
      theme: ThemeData(primarySwatch: Colors.blue), // 设置主题颜色
      home: MyScrollWidget(), // 指定主页
    );
  }
}

class MyScrollWidget extends StatefulWidget {
  @override
  _MyScrollWidgetState createState() => _MyScrollWidgetState();
}

class _MyScrollWidgetState extends State<MyScrollWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
    // 监听滚动事件
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        print(
            "用户手动滚动: ${_scrollController.position.userScrollDirection}");
      } else {
        print("未滚动或通过代码滚动");
      }
    });
  }

  // 使用代码滚动
  void _jumpToPosition() {
    // 通过代码滚动
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  final List<int> _list = [];

  List<int> init() {
    for (int i = 0; i < 150; i++) {
      _list.add(i);
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Detection')),
      body: ListView(
        shrinkWrap: true,
        physics: FixedExtentScrollPhysics(),
        // physics: const BouncingScrollPhysics(
        //   parent: AlwaysScrollableScrollPhysics(),
        // ),
        controller: _scrollController,
        children: _list.map((e) =>
            ListTile(title: Text('Item $e'))
        ).toList(),
        // itemBuilder: (context, index) {
        //   return ListTile(title: Text('Item $index'));
        // },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _jumpToPosition, // 点击按钮时滚动到最底部
        child: Icon(Icons.arrow_downward),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}