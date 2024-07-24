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

///我们从ChangeNotifier到ValueNotifier，
///逐步减少了模板代码的创建，但是依然还有很多问题，
///比如我们还是需要手动addListener、removeListener或者是dispose，
///同时，还需要使用setState来刷新页面，如果Context控制不好，
///很容易造成整个页面的刷新。因此，Flutter在它们的基础之上，
///又提供了ValueListenableBuilder来解决上面这些问题。
//
///链接：https://juejin.cn/post/7381767811679502346

class _CounterPageState extends State<CounterPage> {
  final ValueNotifier<int> _countNotifier = ValueNotifier(0);

  @override
  void dispose() {
    super.dispose();
    _countNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Value Notifier')),
      body: Center(
        child: ValueListenableBuilder(valueListenable: _countNotifier, builder:( context, value,  child){
           return Text("Counter: $value");
        } ),
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
