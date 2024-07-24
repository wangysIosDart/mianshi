import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Key Demo')),
        body: KeyDemo(),
      ),
    );
  }
}

class KeyDemo extends StatefulWidget {
  @override
  _KeyDemoState createState() => _KeyDemoState();
}

class _KeyDemoState extends State<KeyDemo> {
  List<Item> itemsWithKey = [];
  List<Item> itemsWithoutKey = [];

  void addItemWithKey() {
    setState(() {
      itemsWithKey.add(
          Item(
      id: itemsWithKey.length + 1,
      title:'Item ${itemsWithKey.length + 1}'));
    });
  }

  void addItemWithoutKey() {
    setState(() {
      itemsWithoutKey.add(Item(
          id: itemsWithoutKey.length + 1,
          title: 'Item ${itemsWithoutKey.length + 1}'));
    });
  }

  void removeItemWithKey() {
    setState(() {
      if (itemsWithKey.isNotEmpty) {
        itemsWithKey.removeLast();
      }
    });
  }

  void removeItemWithoutKey() {
    setState(() {
      if (itemsWithoutKey.isNotEmpty) {
        itemsWithoutKey.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 带 Key 的列表
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: addItemWithKey, child: Text('+  Key')),
            ElevatedButton(onPressed: removeItemWithKey, child: Text('- Key')),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itemsWithKey.length,
            // findChildIndexCallback: (Key key){
            //   final int id = (key as ValueKey<int>).value;
            //   final index = itemsWithKey.indexWhere((element) => element.id == id);
            //   return index > -1 ? index:null;
            // },
            itemBuilder: (context, index) {
              return ItemWidget(
                  key: ValueKey(itemsWithKey[index].id), // 使用 Key
                  itemsWithoutKey[index].title);
            },
          ),
        ),
        // 不带 Key 的列表
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: addItemWithoutKey, child: Text('+ Without Key')),
            ElevatedButton(onPressed: removeItemWithoutKey, child: Text('- Without Key')),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itemsWithoutKey.length,
            itemBuilder: (context, index) {
              return ItemWidget(itemsWithoutKey[index].title);
            },
          ),
        ),
      ],
    );
  }
}

class ItemWidget extends StatefulWidget {
  final String title;
  const ItemWidget(this.title,{super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  void initState() {
    super.initState();
    print('init:${widget.title}');
  }
  @override
  Widget build(BuildContext context) {
     return ListTile(
      title: Text(widget.title),
    );
  }
}


class Item {
  final String title;
  final int id;

  Item({
    required this.title,required this.id
});// 唯一标识符
}