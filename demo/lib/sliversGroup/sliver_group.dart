import 'dart:math';

import 'package:flutter/material.dart';

///3. 交叉轴分组相关 Sliver 组件
/// 其中 SliverConstrainedCrossAxis 和 SliverCrossAxisExpanded 用于控制滑片在交叉轴的尺寸；有人可能会疑惑，一般来说，交叉轴方向的尺寸不就是视口尺寸吗，为什么需要控制交叉轴方向的滑片尺寸呢？有些场景下，我们期望交叉轴方向可以排若干个 Sliver 滑块，共同响应滚动，特别是像宽度充裕的桌面端。
/// 如下所示，左中右三块 SliverList 水平排布，共同滑动。这种场景在之前是很难实现的，现在有了 SliverCrossAxisGroup 组件，就可以在竖直滑动视口中，将若干个 Sliver 水平排列，作为一个滑片组。而 SliverConstrainedCrossAxis 和 SliverCrossAxisExpanded  两个组件就是用于控制滑片在交叉轴方向尺寸的，所以说这三位是同一条船上的。
///
/// 作者：张风捷特烈
/// 链接：https://juejin.cn/post/7268228858762870784
/// 来源：稀土掘金
/// 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
///

class SliverCrossAxisGroupExample extends StatelessWidget {
  const SliverCrossAxisGroupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SliverGroup'),),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.green,
              alignment: Alignment.center,
              child: const Text(
                '顶部固定banner',
                style: TextStyle(
                    fontSize: 25
                ),
              ),
            ),
          ),
          SliverCrossAxisGroup(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: _MySliverHeaderDelegate(
                  minHeight: 600.0, // 最小高度
                  maxHeight: 600.0, // 最大高度
                  child: Container(
                    width: 100,
                    color: Colors.blue,
                    child: const Center(child: Text('吸顶组件')),
                  ),
                ),
                pinned: true, // 使组件吸顶
              ),
              SliverConstrainedCrossAxis(
                maxExtent: 300,
                sliver: SliverColorList(
                  height: 100.0,
                  fontSize: 24,
                  count: 20,
                  color1: Colors.amber[300],
                  color2: Colors.blue[300],
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              width: double.infinity,
              color: Colors.brown,
              alignment: Alignment.center,
              child: const Text(
                '底部文字说明',
                style: TextStyle(
                    fontSize: 25
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverColorList extends StatelessWidget {
  final double height;
  final double fontSize;
  final Color? color1;
  final Color? color2;
  final int count;
  const SliverColorList(
      {super.key,
        required this.height,
        required this.fontSize,
        required this.count,
        this.color1,
        this.color2});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index.isEven ? color1 : color2,
          height: height,
          child: Center(
            child: Text(
              'Item $index',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        );
      },
      itemCount: count,
    );
  }
}

class _MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _MySliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_MySliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

