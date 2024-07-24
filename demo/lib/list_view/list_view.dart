import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(MaterialApp(builder: (_,c){
    return ListPage();
  }));
}

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }
}

class ListPageState extends State<ListPage> {
  int count = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text('List Test'),
          onTap: () {
            setState(() {});
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text('this is start'),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                print('this is index = $index');
                return _buildItem(index);
              },
              itemCount: 60,
              ///在Flutter开发中的列表组件，设置了shrinkWrap: true属性的都不具有懒加载功能，
              ///解决方案是使用Sliver家族中的列表组件对其进行替换。
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text('this is end'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 1)),
      child: Center(child: Text('$index')),
    );
  }
}