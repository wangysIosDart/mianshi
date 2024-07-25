import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeletonizer Demo',
      theme: ThemeData(
        extensions: const [
          SkeletonizerConfigData(),
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: const [
          SkeletonizerConfigData.dark(),
        ],
      ),
      home: const SkeletonizerDemoPage(),
    );
  }
}

class SkeletonizerDemoPage extends StatefulWidget {
  const SkeletonizerDemoPage({super.key});

  @override
  State<SkeletonizerDemoPage> createState() => _SkeletonizerDemoPageState();
}

class _SkeletonizerDemoPageState extends State<SkeletonizerDemoPage> {
  bool _enabled = true;
  int _count = 1;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        ++_count;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skeletonizer Demo')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0, right: 4),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 110),
          child: FloatingActionButton(
            child: Icon(
              _enabled
                  ? Icons.hourglass_bottom_rounded
                  : Icons.hourglass_disabled_outlined,
            ),
            onPressed: () {
              setState(() {
                _enabled = !_enabled;
              });
            },
          ),
        ),
      ),
      body: Skeletonizer(
        enabled: _enabled,
        enableSwitchAnimation: true,
        child: ListView.builder(
          itemCount: _count,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            if(index < 3){
              return _item2(index);
            }else{
              return _item1(index);
            }
          },
        ),
      ),
    );
  }

  Widget _item1(int index){
    return Card(
      child: ListTile(
        title: Text('Item number $index as title'),
        subtitle: const Text('Subtitle here'),
        trailing: const Icon(
          Icons.ac_unit,
          size: 32,
        ),
      ),
    );
  }

  Widget _item2(int index){
    return Card(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.phone_android,
              size: 34,
              color: Colors.amberAccent,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('哈哈电视剧剧情文',style: TextStyle(
                    fontSize: 14,
                    color: Colors.black
                )),
                const SizedBox(height: 10),
                Text('这是第$index行',style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green
                )),
              ],
            ),
          ],
        )
      ),
    );

    return ListTile(
      title: Text('Item number $index as title'),
      subtitle: const Text('Subtitle here'),
      trailing: const Icon(
        Icons.ac_unit,
        size: 32,
      ),
    );
  }

  Widget _item3(int index){
    return ListTile(
      title: Text('Item number $index as title'),
      subtitle: const Text('Subtitle here'),
      trailing: const Icon(
        Icons.ac_unit,
        size: 32,
      ),
    );
  }
}
