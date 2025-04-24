import 'package:demo/notifier/notifier.dart';
import 'package:demo/webview/web_detail_page.dart';
import 'package:flutter/material.dart';

import 'gujia/shimmer.dart';
import 'river_pod/river_pod_page.dart';
import 'webview/web_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // 统一路由切换IOS风格
  static const Map<TargetPlatform, PageTransitionsBuilder> defaultBuilders =
  <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  };

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'MainPage',
      theme: ThemeData(
        // 使用ios平台风格包括头部样式等<右滑返回>
        platform: TargetPlatform.iOS,
        // 默认字体
        fontFamily: 'PingFang SC',
        // 去除选中的波纹动画效果
        highlightColor: Colors.transparent,
        splashColor:Colors.transparent,
        // 不使用Material3 UI
        useMaterial3: false,
        // 统一路由切换
        pageTransitionsTheme:
         const PageTransitionsTheme(builders: defaultBuilders),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<NavItem> list = [
    NavItem('river_pod', const RiverPodPage()),
    NavItem('notifier', const NotifierPage()),
    NavItem('ShimmerPage', const ShimmerPage()),
    NavItem('WebPage', const WebPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页')),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            var item = list[index];
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return item.page;
                    }));
                  },
                  child: Text(item.title),
                ));
          }),
    );
  }
}

class NavItem {
  final String title;
  final Widget page;

  NavItem(
    this.title,
    this.page,
  );
}
