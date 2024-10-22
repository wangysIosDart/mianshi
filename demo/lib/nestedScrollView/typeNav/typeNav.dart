// import 'package:flutter/material.dart';
// // flutter_screenutil
//
//
// // 当前宽度
// double _itemWidth = 80.0.w;
// // 当前屏幕元素
// double _itemNum = Device.screenWidth / _itemWidth;
//
// /// 老版本的体育详情页 新的每个item 要不同大小
// /// 最左和最有有粘连效果
// /// 滑动到最左边或者最右多次，可能出现重复的???
// /// 暂时不使用这个 加_弃用
// class _SportTypeNav extends StatefulWidget {
//   const _SportTypeNav({
//     super.key,
//     required this.typeId,
//     required this.list,
//     this.loading = false,
//     this.height = 40.0,
//     this.onChange,
//   });
//
//   final String typeId;
//   final List<SportDetailTypeItem> list;
//   final double height;
//   final ValueChanged<String>? onChange;
//   final bool? loading;
//
//   @override
//   _SportTypeNavState createState() => _SportTypeNavState();
// }
//
// class _SportTypeNavState extends State<_SportTypeNav>
//     with SingleTickerProviderStateMixin {
//   // scroll控制器
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     // 增加监听
//     initAddListener();
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//
//     super.dispose();
//   }
//
//   // 需要固定的tab
//   List<SportDetailTypeItem> get fixList {
//     return widget.list.where((value) => value.isFixed == true).toList();
//   }
//
//   // 当前激活index
//   int get currActiveIndex {
//     int index = widget.list.indexWhere((value) => value.id == widget.typeId);
//     return index != -1 ? index : 0;
//   }
//
//   // 获取数据
//   SportDetailTypeItem get typeItem {
//     try {
//       return widget.list[currActiveIndex];
//     } catch (e) {
//       return SportDetailTypeItem.fromJson({});
//     }
//   }
//
//   double offset = 0; // 偏移量
//   bool isClick = false; // 是否点击
//   bool isLeftFixed = false; // 是否左边固定
//   bool isRightFixed = false; // 是否右边固定
//   void initAddListener() {
//     scrollController.addListener(() {
//       if (isClick) {
//         return;
//       }
//       // 时间偏移
//       double currOffset = scrollController.offset;
//       setState(() {
//         offset = currOffset;
//         // 左边固定距离是否大于激活距离
//         isLeftFixed = currOffset > (currActiveIndex - 1) * _itemWidth;
//         // 右边固定距离是否小于激活距离
//         isRightFixed =
//             currOffset < (currActiveIndex - _itemNum + 1) * _itemWidth;
//       });
//     });
//   }
//
//   // tab切换
//   void onChangeId(
//       SportDetailTypeItem value,
//       ) {
//     setState(() {
//       isLeftFixed = false;
//       isRightFixed = false;
//     });
//     if (widget.onChange is Function) {
//       widget.onChange!(value.id);
//     }
//     // 如果是固定不计算
//     if (value.isFixed) {
//       return;
//     }
//     //当前选中index
//     int index = widget.list.indexWhere((item) => item.id == value.id);
//     //是否已经点击
//     isClick = true;
//     // 一屏幕多少, 除以2, 减去单个0.6
//     double num = (_itemNum / 2) - 0.6;
//     // 计算滚动距离
//     double offset = (index - num) * _itemWidth;
//     if (offset < scrollController.position.minScrollExtent) {
//       offset = scrollController.position.minScrollExtent;
//     } else if (offset > scrollController.position.maxScrollExtent) {
//       offset = scrollController.position.maxScrollExtent;
//     }
//     scrollController.animateTo(
//       offset,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//     debounce(() {
//       isClick = false;
//     }, const Duration(milliseconds: 400))();
//   }
//
//   // 返回条目
//   Widget renderItem(SportDetailTypeItem value) {
//     // 是否激活
//     bool isActive = widget.typeId == value.id;
//     // 是否禁用
//     bool isDisabled = widget.loading!;
//     return InkWell(
//       onTap: () => isActive || isDisabled ? null : onChangeId(value),
//       child: Container(
//         width: _itemWidth,
//         height: widget.height,
//         padding: const EdgeInsets.symmetric(horizontal: 2).r,
//         child: Stack(
//           children: <Widget>[
//             Center(
//                 child: Container(
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color:
//                     isActive ? ColorConstant.primaryColor : Colors.transparent,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(24.0),
//                     ).r,
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     value.label,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       color: isActive
//                           ? ColorConstant.whiteColor
//                           : ColorConstant.negativeColor,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 返回左边固定
//   Widget renderLeftFixed() {
//     SportDetailTypeItem item = typeItem;
//     return Positioned(
//       left: offset < 0 ? -offset : 0,
//       top: 0,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ...fixList.map((value) {
//             // 是否激活
//             return Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: renderItem(value),
//             );
//           }),
//           isLeftFixed && item.isFixed == false
//               ? Container(
//             color: Colors.white,
//             child: renderItem(typeItem),
//           )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   // 返回右边固定
//   Widget renderRightFixed() {
//     SportDetailTypeItem item = typeItem;
//     return Positioned(
//       right: 0,
//       top: 0,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           isRightFixed && item.isFixed == false
//               ? Container(
//             color: Colors.white,
//             child: renderItem(item),
//           )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 如果传入空
//     if (widget.list.isEmpty) {
//       return const SizedBox();
//     }
//     return Stack(
//       children: <Widget>[
//         SingleChildScrollView(
//           controller: scrollController,
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: widget.list.map((SportDetailTypeItem value) {
//               return Container(
//                 color: Colors.transparent,
//                 child: renderItem(value),
//               );
//             }).toList(),
//           ),
//         ),
//         renderLeftFixed(),
//         renderRightFixed(),
//       ],
//     );
//   }
// }
