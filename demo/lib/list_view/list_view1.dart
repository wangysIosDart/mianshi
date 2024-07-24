import 'package:flutter/material.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('this is SliverList'),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              print('this is SliverList index = $index');
              return _buildSliverListItem(index);
            }, childCount: 20),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('this is SliverGrid'),
              ),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.5,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                print('this is SliverGrid index = $index');
                return _buildSliverGridItem(index);
              },
              childCount: 20,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('this is end'),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverListItem(int index) {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 1)),
      child: Center(child: Text('$index')),
    );
  }

  Widget _buildSliverGridItem(int index) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1)),
      child: Center(child: Text('$index')),
    );
  }
}
