import 'package:flutter/material.dart';


class NotifierPage extends StatefulWidget {
  const NotifierPage({super.key});

  @override
  _NotifierPageState createState() => _NotifierPageState();
}

class _NotifierPageState extends State<NotifierPage> {
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
