import 'package:demo/nestedScrollView/stickyTabBarDelegate/index.dart';
import 'package:flutter/material.dart';
import 'typeNav/index.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          const SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Pinned AppBar'),
            ),
          ),
          renderTabBar(),
        ];
      },
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: List.generate(20, (e) {
            return ListTile(
              title: Text('Item ${e + 1}'),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _sliverOverlapAbsorber(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            title: const Text('AppBar Title'),
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network('https://picsum.photos/250?image=9'),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(title: Text('Item 1')),
            ListTile(title: Text('Item 2')),
            ListTile(title: Text('Item 3')),
            // ...
          ]),
        ),
      ],
    );
  }

  // render tabbar
  Widget renderTabBar() {
    return SliverSafeArea(
      top: false,
      bottom: false,
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: StickyTabBarDelegate(
            minHeight: 40,
            maxHeight: 40,
            rightAction: InkWell(
              onTap: () {},
              child: Container(
                width: 40,
                alignment: Alignment.center,
                child: Icon(
                  Icons.ac_unit,
                  weight: 30,
                ),
              ),
            ),
            child: const SportTypeNav(
              list: [
                '124124',
                '啊发废弃物',
                '几i味',
                '啊发啊啊',
                'f113afqe',
                'faeqeqe13',
                '发企鹅各'
              ],
            )),
      ),
    );
  }
}
