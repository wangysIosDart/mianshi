import 'dart:math';

import 'package:flutter/material.dart';

import 'web_detail_page.dart';

/// android 端，webview返回之后页面重新刷新了，闪烁了一下
class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  List<String> urlList = [
    'https://img2.baidu.com/it/u=3640235074,3867268882&fm=253&fmt=auto&app=138&f=JPEG?w=1174&h=800',
    'http://img1.baidu.com/it/u=2728049267,390942572&fm=253&app=138&f=JPEG?w=1120&h=800',
    'http://img0.baidu.com/it/u=2399881599,4029264754&fm=253&app=138&f=JPEG?w=800&h=836',
    'https://img1.baidu.com/it/u=655857493,3045561497&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1429',
    'https://b0.bdstatic.com/32a7c914853f8b97379ecd9aab38c8c6.jpg',
    'https://b0.bdstatic.com/10b83723de71431b5ab3cc50c8d1b159.jpg',
  ];

  String url = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网页测试'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 120,
          itemBuilder: (_, index) {
            // 生成随机索引
            int randomIndex = Random().nextInt(urlList.length);
            String randomFruit = urlList[randomIndex];
            url = randomFruit;
            return InkWell(
              onTap: onTap,
              child: Container(
                // height: 40 + index.toDouble(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Image.network(
                      url,
                      width: 120,
                      height: 50,
                      fit: BoxFit.fitWidth,
                    ),
                    Text('我是第$index 行'),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void onTap() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return WebDetailPage();
    })
        // PageRouteBuilder(
        //   pageBuilder: (context, animation, secondaryAnimation) =>
        //       const WebDetailPage(),
        //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //     // 自定义动画效果
        //     return SlideTransition(
        //       position: Tween<Offset>(
        //         begin: const Offset(1.0, 0.0), // 从右侧进入
        //         end: Offset.zero,
        //       ).animate(animation),
        //       child: const WebDetailPage(),
        //     );
        //   },
        //   transitionDuration: const Duration(milliseconds: 300), // 动画时长
        // ),
        );
  }
}
