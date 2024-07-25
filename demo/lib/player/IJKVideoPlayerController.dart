import 'dart:async';

class IJKVideoPlayerController {
  // FutureOr Function()? stop;
  // FutureOr Function()? pause;
  // FutureOr Function()? play;
  // FutureOr Function(int msec)? seekTo;
  // FutureOr Function(double volume)? setVolume;
  // FutureOr Function(double speed)? setSpeed;
  // FutureOr Function(int loopCount)? setLoop;
  // FutureOr Function()? isPlaying;

  void play() {
    if (videoPlayerController.play != null) {
      videoPlayerController.play!.call();
    }
  }
  void pause() {
    if (videoPlayerController.pause != null) {
      videoPlayerController.pause!.call();
    }
  }

  void stop() {
    if (videoPlayerController.stop != null) {
      videoPlayerController.stop!.call();
    }
  }

  void seekTo(int msec) {
    if (videoPlayerController.seekTo != null) {
      videoPlayerController.seekTo!.call(msec);
    }
  }

  void setVolume(double volume) {
    if (videoPlayerController.setVolume != null) {
      videoPlayerController.setVolume!.call(volume);
    }
  }

  void setSpeed(double speed) {
    if (videoPlayerController.setSpeed != null) {
      videoPlayerController.setSpeed!.call(speed);
    }
  }

  void setLoop(int loopCount) {
    if (videoPlayerController.setLoop != null) {
      videoPlayerController.setLoop!.call(loopCount);
    }
  }

  Future<bool?> isPlaying() async {
    if (videoPlayerController.isPlaying != null) {
      bool videoIsPlaying = await videoPlayerController.isPlaying!.call();
      return videoIsPlaying;
    }
    return Future.value(null);
  }



}

