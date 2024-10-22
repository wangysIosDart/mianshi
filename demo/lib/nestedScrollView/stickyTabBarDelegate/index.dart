import 'package:flutter/material.dart';


class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;
  final Widget? rightAction;
  StickyTabBarDelegate({
    this.minHeight = 40,
    this.maxHeight = 120,
    required this.child,
    this.rightAction,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          child,
          rightAction ?? const SizedBox(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
