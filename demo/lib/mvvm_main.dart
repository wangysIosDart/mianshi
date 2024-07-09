import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mvvm/counter_view_model.dart';


///最基本的mvvm
///响应式开发
///
/// 在实现 MVVM 架构时，我们应遵循一些最佳实践，以确保代码的可维护性和可扩展性。例如：
//
/// 1.保持 Model、View 和 ViewModel 的职责单一，避免将过多的逻辑放入一个类中。
/// 2.使用接口和抽象类来定义 Model 和 ViewModel，以便在不同的实现和平台之间共享代码。
/// 3.编写单元测试和集成测试，确保应用的正确性和稳定性。
/// 4.优化性能，避免不必要的重绘和重建。
///
/// 原文链接：https://blog.csdn.net/mba16c35/article/details/138773763



/// Model（模型）
/// 负责数据层，包括数据的获取、存储和管理。
/// 通常包括数据类和与数据相关的业务逻辑。

/// View（视图）
/// 负责 UI 展示，直接与用户交互。
/// 在 Flutter 中，View 通常由 StatelessWidget 或 StatefulWidget 组成。

/// ViewModel（视图模型）
/// 负责业务逻辑和状态管理。
/// 通过 ViewModel 进行数据绑定，将数据传递给 View 并响应用户操作。
/// 在 Flutter 中，ViewModel 通常使用 ChangeNotifier 或其他状态管理解决方案（如 Provider、Riverpod、Bloc 等）


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CounterViewModel(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MVVM Counter')),
      body: Center(
        child: Consumer<CounterViewModel>(
          builder: (context, viewModel, child) {
            return Text('Counter: ${viewModel.value}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterViewModel>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
