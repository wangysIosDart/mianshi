// import 'package:fijkplayer/fijkplayer.dart';
// import 'package:flutter/material.dart';
//
// import 'IJKVideoPanel.dart';
// import 'IJKVideoPlayerController.dart';
//
// /// usage
// /// autoPlay 为 true 时等同于连续调用 setDataSource、prepareAsync、start
// /// fplayer.setDataSource("http://samplevideo.com/sample.flv", autoPlay: true);
// ///
// /// 设置本地资源作为播放源，
// /// pubspec.yml 中需要指定assets 内容
// ///   assets:
// ///     - assets/butterfly.mp4
// ///
// /// scheme 是 `asset`, `://` 是 scheme 分隔符， `/` 是路径起始符号
// /// fplayer.setDataSource("asset:///assets/butterfly.mp4", autoPlay: true);
//
// class IJKVideoPlayer extends StatefulWidget {
//   const IJKVideoPlayer({
//     super.key,
//     required this.path,
//     this.autoPlay = false,
//     this.showCover = true,
//     this.fit = FijkFit.contain,
//     this.cover,
//     this.color = Colors.black,
//     this.width,
//     this.height,
//     this.videoPlayerController,
//   });
//
//   final double? width;
//   final double? height;
//
//   final String path;
//   final bool autoPlay;
//   final bool showCover;
//   final FijkFit fit;
//   final Widget? cover;
//   final Color color;
//   final IJKVideoPlayerController? videoPlayerController;
//
//   @override
//   State<IJKVideoPlayer> createState() => _IJKVideoPlayerState();
// }
//
// class _IJKVideoPlayerState extends State<IJKVideoPlayer> {
//   final FijkPlayer player = FijkPlayer();
//
//   @override
//   void initState() {
//     super.initState();
//     player.setDataSource(
//       widget.path,
//       autoPlay: widget.autoPlay,
//       showCover: widget.showCover,
//     );
//     addVideoPlayerFun();
//   }
//
//   void addVideoPlayerFun() {
//     if (widget.videoPlayerController != null) {
//       widget.videoPlayerController!.play = () {
//         // 触发播放
//         player.start();
//       };
//
//       widget.videoPlayerController!.stop = () {
//         // 触发停止
//         player.stop();
//       };
//
//       widget.videoPlayerController!.pause = () {
//         // 触发暂停
//         player.pause();
//       };
//
//       widget.videoPlayerController!.setLoop = (int loopCount) {
//         // 触发setLoop
//         if (loopCount < 0) {
//           loopCount = 1;
//         }
//         player.setLoop(loopCount);
//       };
//
//       widget.videoPlayerController!.seekTo = (int msec) {
//         // 触发seek
//         if (msec < 0) {
//           msec = 0;
//         }
//         player.seekTo(msec);
//       };
//
//       widget.videoPlayerController!.setVolume = (double volume) {
//         // 触发setVolume
//         if (volume < 0.0) {
//           volume = 0.0;
//         }
//
//         player.setVolume(volume);
//       };
//
//       widget.videoPlayerController!.setSpeed = (double speed) {
//         // 触发setSpeed
//         if (speed < 0.0) {
//           speed = 1.0;
//         }
//
//         player.setSpeed(speed);
//       };
//
//       widget.videoPlayerController!.isPlaying = () {
//         // 触发setVolume
//         if (FijkState.started == player.state) {
//           return true;
//         } else {
//           return false;
//         }
//       };
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     player.release();
//   }
//
//   void onIJKDispose(FijkData fijkData) {}
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           widget.cover != null ? widget.cover! : Container(),
//           FijkView(
//             width: widget.width,
//             height: widget.height,
//             player: player,
//             fit: widget.fit,
//             fsFit: widget.fit,
//             color: widget.color,
//             onDispose: onIJKDispose,
//             panelBuilder: (FijkPlayer player, FijkData data,
//                 BuildContext context, Size viewSize, Rect texturePos) {
//               return IJKVideoPanel(
//                 player: player,
//                 buildContext: context,
//                 viewSize: viewSize,
//                 texturePos: texturePos,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
