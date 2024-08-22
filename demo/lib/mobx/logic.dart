// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'package:demo/mobx/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:async';

// MobX Store

// 主程序
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  // 初始化定时器
  Timer? timer;

  void _initTimer() {
    _clearTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      print('periodic');
    });
  }

  // 清除定时器
  void _clearTimer() {
    // 页面销毁时触发定时器销毁
    if (timer == null) {
      return;
    }
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MobX Bool Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用 Observer 来监听 show 的状态
            Observer(builder: (_) {
              return Visibility(
                visible: counter.show, // 依据 show 的值来决定是否可见
                child: Text("This text is shown when show is true"),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: counter.toggleShow,
              child: Text("Toggle Show"),
            ),
          ],
        ),
      ),
    );
  }
}
