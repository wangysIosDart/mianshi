


//########### 面试提问：flutter app 如何实现热修复和热更新？？最近美团开源一个了解吗？

//要么生成上层代码，比如js控制，或者判断JSON配置文件；再生成dart
//要么生成运行时代码。

/// 确定无论是 IOS 还是 Android APP 业务代码都是由四个段组成：
///
//Dart isolate 数据段 类信息，全局变量，函数指针等 允许动态下发
/// kDartVmSnapshotData、

//Dart isolate 指令段 包含由 Dart isolate 执行的 AOT 代码 IOS 不允许动态下发
/// kDartVmSnapshotInstructions、
///
//vm isolate 数据段 isolate 之间共享的 Dart 堆 (heap) 的初始状态 允许动态下发
/// kDartIsolateSnapshotData、
///
//vm isolate 指令段 包含 VM 中所有 Dart isolate 之间共享的通用程序的 AOT 指令 IOS 不允许动态下发
/// kDartIsolateSnapshotInstructions；
///
///
/// 理论上只要能动态替换加载的代码段 & 数据段代码即可实现目标。

/// 参看链接：https://zhuanlan.zhihu.com/p/632352296



/// ################ 方案一 ################
///根据上面的技术分析结果，已经可以独立生成自己的代码段，数据段文件。通过需改虚拟机底层代码的方式，
///也可以动态的加载运行。但由于 IOS 系统目前底层的系统还不能动态加载可读写的代码段数据到内存中，
///所以还有技术难点需要突破。但 Android 端有更简单的路径可以解决。
// 1， 修改 Flutter Engine 代码，加载指定路径的 libapp.so 和 flutter_aasets，比如私有目录 (data/data/files)；
// 2， 编译 APK 时，利用 Gradle Transform 插件，根据 Flutter SDK 的 engine version 动态替换官方的 Flutter engine，最终写入修改后的 engine 到 APK；
// 3， 生成补丁包：利用 BSdiff 算法比较新旧 APK 文件，生成 patch 补丁包
// 4， APP 启动时访问后端接口，根据参数（app 的版本号，补丁包版本号，md5，flutter SDK 版本号，Engine 版本号）拉取补丁包；
// 5， 合成补丁包：校验 md5，app 版本号，补丁版本号，安装时间；
// 6， 自定义 Flutter Engine 加载指定路径的 libapp.so 和 flutter_assets 资源文件；


/// ################ 方案二 自己实现页面布局动态化 ################
/// 在端上提前开发好一堆可定制的组件。然后在配置后台配置页面使用哪些组件以及组件对应的数据，
/// 每个页面通过下发给客户端一个JSON文件，客户端解析后在页面中加载对应的组件。
/// 这种方案更进一步就是把整个页面布局都做成可配置的，定义一套页面布局协议。比如下发一个页面布局的JSON，包含各个Widget的位置，客户端上通过解析JSON转换成页面布局控件树。
/// 该方案可以实现页面的动态化，但是逻辑无法动态化，比如想对数据做一个筛选就无法动态下发。


//https://www.zhihu.com/question/268550907/answer/3030031486
/// ################ 方案三：加入一个支持动态下发的运行时 ################
///
/// 这种方案本质上和RN的原理一样，只不过把原生的部分替换成了Flutter实现。通过动态下发JS，
/// 页面布局经过解析后传递给Flutter完成渲染，逻辑部分直接在JS层面执行完成，然后将结果一并传给Flutter。
/// 这种方案比较典型的有腾讯的MXFlutter。


//https://juejin.cn/post/7358672588716163112?searchId=20240709160354E3E60B76AF4229847957
/// ################ 方案四：Shorebird (Code Push)  ################
///老外开发的框架，使用需要收费！支持2端


/// ################ 方案五：58 fair  ################
/// Fair 整体设计原则是要打造一个还是 Flutter 技术栈的、可通过市场审核的热更新方案。
/// 所以整体架构设计，是将 Dart 源文件转译成 DSL 通过下发 JSON 和 JS 来分别实现布局动态化和逻辑动态化。
///
/// https://github.com/wuba/fair
/// https://baijiahao.baidu.com/s?id=1773567963984172689&wfr=spider&for=pc



/// ################ 方案六：美团 flap  ################
/// https://tech.meituan.com/2020/06/23/meituan-flutter-flap.html