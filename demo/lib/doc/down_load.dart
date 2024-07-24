///断点续传或者下载？
///
/// 前提：服务器必须支持header的ranger字段
/// 例：请求头中添加"Range: bytes=0-10"，后端返回 Content-Range:bytes 0-10/233295878，
/// 0-10表示本次返回的区块，233295878代表文件的总长度，单位都是byte,  也就是该文件大概233M多一点。
///
/// https://www.jb51.net/article/157739.htm
///
/// 综上所述，我们可以设计一个简单的多线程的文件分块下载器，实现的思路是：
//
// 1.先检测是否支持分块传输，如果不支持，则直接下载；
// 2.若支持，则将剩余内容分块下载。
// 3.各个分块下载时保存到各自临时文件，等到所有分块下载完后合并临时文件。
// 4.删除临时文件。

///
/// 通过第一个分块请求检测服务器是否支持分块传输
// Response response = await downloadChunk(url, 0, firstChunkSize, 0);
// if (response.statusCode == 206) {  //如果支持
      ///解析文件总长度，进而算出剩余长度
//   total = int.parse(
//     response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
//   int reserved = total -
//     int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      ///文件的总块数(包括第一块)
//   int chunk = (reserved / firstChunkSize).ceil() + 1;
//   if (chunk > 1) {
//     int chunkSize = firstChunkSize;
//     if (chunk > maxChunk + 1) {
//       chunk = maxChunk + 1;
//       chunkSize = (reserved / maxChunk).ceil();
//     }
//     var futures = <Future>[];
//     for (int i = 0; i < maxChunk; ++i) {
//       int start = firstChunkSize + i * chunkSize;
        ///分块下载剩余文件
//       futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
//     }
      ///等待所有分块全部下载完成
//     await Future.wait(futures);
//   }
  ///合并文件文件
//   await mergeTempFiles(chunk);
// }

///下面我们使用Flutter下著名的Http库dio的download API 实现downloadChunk：
///start 代表当前块的起始位置，end代表结束位置
///no 代表当前是第几块
// Future<Response> downloadChunk(url, start, end, no) async {
//  progress.add(0); //progress记录每一块已接收数据的长度
//  --end;
//  return dio.download(
//   url,
//   savePath + "temp$no", //临时文件按照块的序号命名，方便最后合并
//   onReceiveProgress: createCallback(no), // 创建进度回调，后面实现
//   options: Options(
//    headers: {"range": "bytes=$start-$end"}, //指定请求的内容区间
//   ),
//  );
// }

///接下来实现mergeTempFiles:
// Future mergeTempFiles(chunk) async {
//   File f = File(savePath + "temp0");
//   IOSink ioSink= f.openWrite(mode: FileMode.writeOnlyAppend);
//   //合并临时文件
//   for (int i = 1; i < chunk; ++i) {
//     File _f = File(savePath + "temp$i");
//     await ioSink.addStream(_f.openRead());
//     await _f.delete(); //删除临时文件
//   }
//   await ioSink.close();
//   await f.rename(savePath); //合并后的文件重命名为真正的名称
// }

///分块下载有什么实际的用处吗？
//分块下载还有一个比较使用的场景是断点续传，可以将文件分为若干个块，
// 然后维护一个下载状态文件用以记录每一个块的状态，这样即使在网络中断后，
// 也可以恢复中断前的状态，具体实现读者可以自己尝试一下，还是有一些细节需要特别注意的，
// 比如分块大小多少合适？下载到一半的块如何处理？要不要维护一个任务队列？

///分块下载真的能提高下载速度吗？
//其实下载速度的主要瓶颈是取决于网络速度和服务器的出口速度，如果是同一个数据源，
// 分块下载的意义并不大，因为服务器是同一个，出口速度确定的，主要取决于网速，
// 而上面的例子正式同源分块下载，读者可以自己对比一下分块和不分块的的下载速度。
// 如果有多个下载源，并且每个下载源的出口带宽都是有限制的，这时分块下载可能会更快一下，
// 之所以说“可能”，是由于这并不是一定的，比如有三个源，三个源的出口带宽都为1G/s，
// 而我们设备所连网络的峰值假设只有800M/s，那么瓶颈就在我们的网络。
// 即使我们设备的带宽大于任意一个源，下载速度依然不一定就比单源单线下载快，
// 试想一下，假设有两个源A和B，速度A源是B源的3倍，如果采用分块下载，
// 两个源各下载一半的话，读者可以算一下所需的下载时间，
// 然后再算一下只从A源下载所需的时间，看看哪个更快。
//分块下载的最终速度受设备所在网络带宽、源出口速度、每个块大小、
// 以及分块的数量等诸多因素影响，实际过程中很难保证速度最优。
// 在实际开发中，读者可可以先测试对比后再决定是否使用

