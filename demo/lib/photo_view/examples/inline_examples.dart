import 'package:demo/photo_view/examples/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class InlineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleAppBarLayout(
      title: "Inline usage",
      showGoBack: true,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "Example of usage in a contained context",
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            height: 200.0,
            child: ClipRect(
              child: PhotoView(
                imageProvider: const AssetImage("assets/large-image.jpg"),
                maxScale: PhotoViewComputedScale.covered * 2.0,
                minScale: PhotoViewComputedScale.contained * 0.8,
                initialScale: PhotoViewComputedScale.covered,
              ),
            ),
          )
        ],
      ),
    );
  }
}
