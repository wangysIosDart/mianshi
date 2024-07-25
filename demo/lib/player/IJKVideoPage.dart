// import 'package:flutter/material.dart';
// import 'IJKVideoPlayer.dart';
// import 'IJKVideoPlayerController.dart';
//
//
// class IJKVideoPage extends StatefulWidget {
//   const IJKVideoPage({
//     super.key,
//     required this.url,
//   });
//
//   final String url;
//
//   @override
//   State<IJKVideoPage> createState() => _IJKVideoPageState();
// }
//
// class _IJKVideoPageState extends State<IJKVideoPage> {
//   final IJKVideoPlayerController videoPlayerController =
//   IJKVideoPlayerController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(title: Text("Fijkplayer Example")),
//       body: Center(
//         child: Container(
//           width: size.width,
//           height: size.width * 9.0 / 16.0,
//           alignment: Alignment.center,
//           child: IJKVideoPlayer(
//             path: widget.url,
//             videoPlayerController: videoPlayerController,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
//
//
