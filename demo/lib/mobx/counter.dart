import 'package:mobx/mobx.dart';
// Include generated file
// 必须有，为了生成 .g 文件
part 'counter.g.dart';

// This is the class used by rest of your codebase
// .g 文件会生成 _$Counter
class Counter = _Counter with _$Counter;

final Counter counter = Counter();
// The store-class
abstract class _Counter with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value = 1;
  }


  @observable
  bool show = true;

  @action
  void toggleShow() {
    show = false;
  }

}