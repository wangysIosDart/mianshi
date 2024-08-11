

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '对话框示例',
      theme: ThemeData(primarySwatch: Colors.blue), // 设置主题颜色
      home: HomeScreen(), // 指定主页
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('对话框示例')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog1(context); // 显示第一个对话框
          },
          child: Text('显示对话框 1'),
        ),
      ),
    );
  }

  void showDialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('对话框 1'),
          content: Text('这是第一个对话框。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框 1
                showDialog2(context); // 显示对话框 2
              },
              child: Text('确认'),
            ),
          ],
        );
      },
    );
  }

  void showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('对话框 2'),
          content: Text('这是第二个对话框。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框 2
                showDialog3(context); // 显示对话框 3
              },
              child: Text('确认并打开对话框 3'),
            ),
          ],
        );
      },
    );
  }

  void showDialog3(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('对话框 3'),
          content: Text('这是第三个对话框。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框 3
              },
              child: Text('关闭'),
            ),
          ],
        );
      },
    );
  }
}