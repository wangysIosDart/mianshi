import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebDetailPage extends StatefulWidget {
  const WebDetailPage({super.key});

  @override
  State<WebDetailPage> createState() => _WebDetailPageState();
}

class _WebDetailPageState extends State<WebDetailPage> {
  String url = '';
  List<String> urlList = [
    'https://anbo360.com/app/home',
    'https://github.com/wangysIosDart/mianshi/tree/main/demo',
    'https://search.bilibili.com/all?keyword=typescript&from_source=webtop_search&spm_id_from=333.1007&search_source=2',
    'https://sesamelabs.xyz/xterio/?referrerCode=zUw6t6htmqw&tab=home',
    'https://app.hyperlock.finance/#/'
  ];

  @override
  void initState() {
    // 生成随机索引
    int randomIndex = Random().nextInt(urlList.length);
    String randomFruit = urlList[randomIndex];
    url = randomFruit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse(url)),
      ),
    );
  }
}
