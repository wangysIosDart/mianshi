import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ① 创建一个状态提供者，StateProvider会观察一个值，并再改变时得到通知
final clickCountProvider = StateProvider<int>((ref) => 0);

void main() {
  // ② 想使用Riverpod 的 Provider 必须用 ProviderScope 包裹MyApp！
  runApp(const ProviderScope(child: MyApp()));
}

// ③ 继承ConsumerWidget，它是可以提供监听Provider的Widget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ④ 通过ref.watch() 来监听Provider的值，当Provider的值改变时，会自动刷新UI
    final int count = ref.watch(clickCountProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Demo')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击计数：$count'),
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CountPage()),
                  );
                },
                child: const Text('跳转到增加计数页面'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class CountPage extends ConsumerWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(clickCountProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('增加计数'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击计数：$count'),
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  // ⑤ 获取Provider的通知器修改状态值(自增)
                  ref.read(clickCountProvider.notifier).state++;
                },
                child: const Text('点击计数+1'),
              ),
            ),
          ],
        )));
  }
}
