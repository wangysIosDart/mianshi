// ————————————————
//
//  版权声明：本文为博主原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接和本声明。
//
// 原文链接：https://blog.csdn.net/gloryFlow/article/details/136024588
///使用better_player播放器进行播放视频时候，
///在Android上会出现解码失败的问题，better_player使用的是video_player，
///video_player很多视频无法解码。最终采用ijkplayer播放器插件，在flutter上使用fijkplayer插件。
///
/// fijkPlayer 就是对 native C 层 ijkplayer 的一个 dart 包装，接口都保持一致。
/// FijkPlayer 处理所有播放相关的工作，实际工作都是由 native C 层 ijkplayer 完成，
/// 包含检查 dataSource 中的媒体信息，打开解码器和解码线程、打开音频输出设备、
/// 将解码后数据输出给音频设备或显示设备
///
//
//目前Flutter平台主流的两个播放器是video_player和fijkplayer的对比
/// https://www.jianshu.com/p/edb2cf5f87a0

/// fijkplayer
// 1、fijkplayer 是一个 Flutter 生态的媒体播放器，是对 ijkplayer 的 Flutter 封装，支持 Android 和 iOS。 fijkplayer 使用 ijkplayer 作为播放器内核，ijkplayer 使用 ffmpeg 进行音视频解封装和解码，同时添加了 Android 和 iOS 平台特有的硬件加速解码能力。
// 2 、国内有QQ群，但是活跃度也是不高。
// 3、可以缓存视频，可以自定义缓存的地址，方便后续的内存维护。
// 4、可以通过FijkPanelWidgetBuilder较大程度上自定义UI。
// 5、无网络有缓存视频时，无法展示封面，因为内部是通过imageProvider去加载网络图片的。
/// 6、播放失败无手动retry的设计

/// video_player
// 1、Flutter平台官方插件，作者是国外的，有问题沟通比较困难，只能通过提交issue
// 2、硬解码
// 4、UI封装：better_player
// 基于video_player和Chewie的高级视频播放器。它解决了许多典型的用例，并且易于运行。
// 5、播放器宽高比例与视频内容宽高比例不一致时，会出现图像压缩变形的问题
// 6、调用原生内核播放器：iOS--AVPlayer， Android--ExoPlayer
// 7、对于分段源 m3u8 的播放不友好，如果一个切片播放超时，会导致整个播放都失败
// 8、better_player可以缓存视频，但不能自定义缓存的地址，只能指定key，和缓存的最大内存量（还未研究超出最大的话是不能缓存新的，还是删除最旧的）
// 9、better_player不能完全自定义UI，只能修改类中的一些开放属性，比如说icon图标，文字颜色啥的
// 10、无网络有缓存时，封面可以正常展示
/// 11、better_player播放失败有手动retry的设计



///aes128加密的视频流
///下载是另外地址,下载下来一般是mp4，也有少量m3u8
///跟播放地址不一样，播放地址都是m3u8