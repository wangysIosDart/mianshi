import 'package:demo/nestedScrollView/NestedScrollView.dart';
import 'package:demo/nestedScrollView/stickyTabBarDelegate/index.dart';
import 'package:flutter/material.dart';
import 'typeNav/index.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: NestedScrollViewWidget(),
      ),
    );
  }
}
