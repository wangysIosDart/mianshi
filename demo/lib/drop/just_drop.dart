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
      home: JustTool(),
    );
  }
}


class JustTool extends StatefulWidget {
  const JustTool({super.key});

  @override
  State<JustTool> createState() => _JustToolState();
}

class _JustToolState extends State<JustTool> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('It goes under me')),
      body: JustTheTooltipArea(
        builder: (context, tooltip, scrim) {
          return Stack(
            fit: StackFit.passthrough,
            children: [
              ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  if (index == 15) {
                    return JustTheTooltipEntry(
                      tailLength: 10.0,
                      preferredDirection: AxisDirection.down,
                      isModal: true,

                      margin: const EdgeInsets.all(20.0),
                      content: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 120,
                                color: Colors.blue,
                                width: double.infinity,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Quia ducimus eius magni voluptatibus ut veniam ducimus. Ullam ab qui voluptatibus quos est in. Maiores eos ab magni tempora praesentium libero. Voluptate architecto rerum vel sapiente ducimus aut cumque quibusdam. Consequatur illo et quos vel cupiditate quis dolores at.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: const Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        elevation: 4.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.touch_app,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListTile(title: Text('Item $index'));
                },
              ),
// In the case of no scrim showing, this will return an SizedBox.shrink
              scrim,
// In the case of no scrim showing, this will return an SizedBox.shrink
              tooltip,
            ],
          );
        },
      ),
    );
  }
}
