
import 'package:demo/listview/detailPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MainPage',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> idList = [];

  @override
  void initState() {
    super.initState();
    List<String> data = [];
    for (int i = 0; i < 100; i++) {
      data.add('我是id：$i');
    }
    idList.addAll(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页')),
      body: ListView.builder(
          itemCount: idList.length,
          itemBuilder: (_, index) {
            String item = idList[index];
            return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailPage(
                        text: item,
                        onChange: (value) {
                          if (!value) {
                            // List<String> temp = [];
                            // temp.addAll(idList);
                            // temp.insert(index, item);

                            setState(() {
                              idList.insert(index, item);
                            });

                            print(
                                '添加index:$index,id:$value,item:$item,idList:${idList.length}');
                          } else {
                            List<String> temp = [];
                            temp.addAll(idList);
                            // temp.removeAt(index);

                            setState(() {
                              // idList = temp;
                              idList.removeAt(index);
                            });
                            print(
                                '删除index:$index,id:$value,item:$item,idList:${idList.length}');
                          }
                        });
                  }));
                },
                child: Center(
                  child: Text(
                    idList[index],
                    style: const TextStyle(fontSize: 30),
                  ),
                ));
          }),
    );
  }
}
