import 'package:demo/photo_view/examples/common/app_bar.dart';
import 'package:demo/photo_view/examples/common_use_cases_examples.dart';
import 'package:demo/photo_view/examples/controller_example.dart';
import 'package:demo/photo_view/examples/custom_child_examples.dart';
import 'package:demo/photo_view/examples/dialog_example.dart';
import 'package:demo/photo_view/examples/gallery/gallery_example.dart';
import 'package:demo/photo_view/examples/hero_example.dart';
import 'package:demo/photo_view/examples/inline_examples.dart';
import 'package:demo/photo_view/examples/network_images.dart';
import 'package:flutter/material.dart';
import 'rotation_examples.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo View Example App',
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ExampleAppBar(title: "Photo View"),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "See bellow examples of some of the most common photo view usage cases",
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommonUseCasesExamples(),
                      ),
                    );
                  },
                  text: "Common use cases",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GalleryExample(),
                      ),
                    );
                  },
                  text: "Gallery",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HeroExample(),
                      ),
                    );
                  },
                  text: "Hero animation",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NetworkExamples(),
                      ),
                    );
                  },
                  text: "Network images",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ControllerExample(),
                      ),
                    );
                  },
                  text: "Controller",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InlineExample(),
                      ),
                    );
                  },
                  text: "Part of the screen",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomChildExample(),
                      ),
                    );
                  },
                  text: "Custom child",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DialogExample(),
                      ),
                    );
                  },
                  text: "Integrated to dialogs",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GestureRotationExample(),
                      ),
                    );
                  },
                  text: "Rotation Gesture",
                ),
                _buildItem(
                  context,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgrammaticRotationExample(),
                      ),
                    );
                  },
                  text: "Rotation Programmatic",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(context,
      {required String text, required VoidCallback onPressed}) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      ),
      onPressed: onPressed,
    );
  }
}
