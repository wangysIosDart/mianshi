
import 'package:flutter/foundation.dart';
import 'counter.dart';

class CounterViewModel extends ChangeNotifier {
  final Counter _counter = Counter();

  int get value => _counter.value;

  void increment() {
    _counter.increment();
    notifyListeners();
  }
}