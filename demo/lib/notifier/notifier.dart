import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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

class _CounterPageState extends State<CounterPage> {
  final CountNotifier _countNotifier = CountNotifier();
  int _count = 0;

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
      _count = _countNotifier.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifier')),
      body: Center(
        child: Text('Counter: $_count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _countNotifier.increase();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CountNotifier with ChangeNotifier{
  int count = 0;
  ///需要手动调用 notifyListeners
  void increase(){
    ++count;
    notifyListeners();
  }
}
