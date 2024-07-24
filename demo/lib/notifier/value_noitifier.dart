import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}


///从源码可以看见，ValueNotifier就是在set方法中，
///帮你调用了下notifyListeners()方法。同时，
///ValueNotifier封装了一个泛型变量，简化了ChangeNotifier的创建过程，
///所以大部分时间我们都是直接使用ValueNotifier。

class _CounterPageState extends State<CounterPage> {
  final ValueNotifier<int> _countNotifier = ValueNotifier(0);

  @override
  void dispose() {
    super.dispose();
    _countNotifier.removeListener(updateCount);
  }

  @override
  void initState() {
    super.initState();
    _countNotifier.addListener(updateCount);
  }

  void updateCount(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Value Notifier')),
      body: Center(
        child: Text('Counter: ${_countNotifier.value}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ++_countNotifier.value;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
