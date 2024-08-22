import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tooltip with Blur Background',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMenu = false;

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tooltip with Blur Background'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _toggleMenu,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(child: Text('Main Content')),
          if (_showMenu) _buildBlurredTooltip(),
        ],
      ),
    );
  }

  Widget _buildBlurredTooltip() {
    return GestureDetector(
      onTap: _toggleMenu, // 点击外部区域关闭菜单
      child: Stack(
        children: [
          // 模糊背景
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Tooltip 风格菜单
          Center(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.all(16),
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: 'Option 1',
                      child: Text('Option 1'),
                    ),
                    Divider(),
                    Tooltip(
                      message: 'Option 2',
                      child: Text('Option 2'),
                    ),
                    Divider(),
                    Tooltip(
                      message: 'Option 3',
                      child: Text('Option 3'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

