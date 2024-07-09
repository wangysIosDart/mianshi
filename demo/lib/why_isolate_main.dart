import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('isolate Demo')),
        body: TestWidget(),
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestWidgetState();
  }
}

/**
UI包含两个部分，一个不断转圈的progress指示器，一个按钮，当点击按钮的时候，找出比某个
正整数n小的数的偶数的个数（请忽视具体算法，故意做耗时计算用，哈哈）。
我们来运行一下代码看看效果：

可以看到，本来是很流畅的转圈，当我点击按钮计算的时候，UI出现了卡顿，为什么会出现卡顿，
因为我们的计算默认是在UI线程中的，当我们调用countEven的时候，这个计算需要耗时，而在这期间，
UI是没有机会去调用刷新的，因此会卡顿，计算完成后，UI恢复正常刷新。
*/

class TestWidgetState extends State<TestWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
            ElevatedButton(
                onPressed: () async {
                  _count = countEven(1000000000);
                  setState(() {});
                },
                child: Text(
                  'countEven: ${_count.toString()}',
                )),
            ElevatedButton(
                onPressed: () async {
                  _count = await asyncCountEven(1000000000);
                  setState(() {});
                },
                child: Text(
                  'asyncCountEven: ${_count.toString()}',
                )),

            /**
          但是由于dart中的Isolate比较重量级，UI线程和Isolate中的数据的传输比较复杂，
          因此flutter为了简化用户代码，在foundation库中封装了一个轻量级compute操作，
              我们先看看compute，然后再来看Isolate
          */
            ElevatedButton(
                onPressed: () async {
                  _count = await compute(countEven, 1000000000);
                  setState(() {});
                },
                child: Text(
                  'compute.isolate: ${_count.toString()}',
                )),
            ElevatedButton(
                onPressed: () async {
                  _count = await portIsolateCountEven(1000000000);
                  setState(() {});
                },
                child: Text(
                  'port.isolate: ${_count.toString()}',
                )),
          ],
        ),
      ),
    );
  }

  ///计算偶数的个数
  static int countEven(int num) {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  /// 仍然卡顿，说明异步是解决不了问题的，为什么？因为我们仍旧是在同一个UI线程中做运算，
  /// 异步只是说我可以先运行其他的，等我这边有结果再返回，但是，记住，我们的计算仍旧是在这个UI线程，
  /// 仍会阻塞UI的刷新，异步只是在同一个线程的并发操作。

  /// a. 将count改为asyncCountEven
  static Future<int> asyncCountEven(int num) async {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  // a. 增加这两个函数
  static Future<dynamic> portIsolateCountEven(int num) async {
    //创建接收端口，用来接收子线程消息
    final response = ReceivePort();

    //创建并发Isolate，并传入主线程发送端口
    await Isolate.spawn(countEvent2, response.sendPort);

    //子线程处理 调用
    final sendPort = await response.first;
    final answer = ReceivePort();
    sendPort.send([answer.sendPort, num]);
    return answer.first;
  }

  static void countEvent2(SendPort port) {
    final rPort = ReceivePort();
    port.send(rPort.sendPort);
    rPort.listen((message) {
      final send = message[0] as SendPort;
      final n = message[1] as int;
      send.send(countEven(n));
    });
  }

  /// b. 使用
}
