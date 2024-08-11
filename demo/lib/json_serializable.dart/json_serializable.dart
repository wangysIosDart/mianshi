import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends  StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Json')),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('data')
              ],
            )),
      ),
    );
  }
}
