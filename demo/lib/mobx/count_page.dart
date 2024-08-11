import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Mobx')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            counter.increment();
            counter.toggleShow();
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Observer(builder: (_) {
              return Text('点击计数：$counter');
            }),
            Observer(builder: (_) {
              return Offstage(
                  offstage: counter.value == 0, child: const Text('int'));
            }),
            Observer(builder: (_) {
              bool show = counter.show == true;
              return Offstage(
                  offstage: show, child: const Text('bool'));
            }),
          ],
        )),
      ),
    );
  }
}
