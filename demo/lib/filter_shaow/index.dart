// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// // flutter_screenutil
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:packet_app/components/button/index.dart';
// import 'package:packet_app/constants/routerUtil.dart';
//
// // mobx
// import 'package:packet_app/pages/auth/signIn/user.store.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
//
// // constants
// import 'package:packet_app/constants/device.dart';
// import 'package:packet_app/constants/color.dart';
//
// // components
// import 'package:packet_app/components/header/index.dart';
// import 'package:packet_app/components/image/index.dart';
// import 'package:packet_app/pages/home/home/components/header/arrowPopMenu/arrow_pop_model.dart';
// import 'package:packet_app/pages/home/home/components/header/arrowPopMenu/arrow_popup.dart';
// import 'package:packet_app/pages/home/home/components/financeCard/index.dart';
// import 'package:packet_app/pages/auth/line/index.dart';
// import 'package:packet_app/pages/home/home/components/vipIcon/index.dart';
//
// // utils
// import 'package:packet_app/utils/number.dart';
//
// class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
//   const HomeHeader({
//     super.key,
//     this.toolbarHeight = Device.toolbarHeight,
//   });
//
//   final double toolbarHeight;
//   @override
//   State<HomeHeader> createState() => _HomeHeaderState();
//
//   @override
//   Size get preferredSize => Size.fromHeight(toolbarHeight.w);
// }
//
// class _HomeHeaderState extends State<HomeHeader> {
//   // 高度
//   void onPathLine(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const LinePage()),
//     );
//   }
//
//   //给获取详细信息的widget设置一个key
//   GlobalKey iconKey = GlobalKey();
//
//   //获取位置，给后续弹窗设置位置
//   late Offset iconOffset;
//
//   //获取size 后续计算弹出位置
//   late Size iconSize;
//
//   //接受弹窗类构造成功传递来的关闭参数
//   // late Function closeModel;
//
//   final double _contentWidth = 132.r;
//
//   final double _contentHeight = 56.r;
//
//   final double _arrowHeight = 8.r;
//
//   // _contentWidth
//   final double _width = 132.r;
//
//   //_contentHeight + _arrowHeight
//   final double _height = 64.r;
//
//   void showModel(BuildContext context) {
//     Navigator.push(
//       context,
//       ArrowPopup(
//         child: ArrowPopModel(
//           left: iconOffset.dx- _width + iconSize.width+8.r,
//           top: iconOffset.dy + iconSize.height,
//           // 动画的起点方向
//           offset: Offset(_width / 2, -_height / 2),
//           // 最外层的大小
//           child: SizedBox(
//             width: _width,
//             height: _height,
//             child: buildMenu(),
//           ),
//           fun: (close) {
//             // closeModel = close;
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildMenu() {
//     return Stack(
//       children: [
//         Positioned(
//           right:10.r,
//           top: 0.5.r, //加个0.5，不然三角形和长方形有细小的间隙
//           child:  Image.asset(
//             'assets/platform/home/financeCard/arrow_up.png.webp',
//             height: _arrowHeight,
//           ),
//         ),
//         //菜单内容
//         Positioned(
//           bottom: 0,
//           child: Container(
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10)
//             ),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//               child: Container(
//                 width: _contentWidth,
//                 height: _contentHeight,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                       width: 1.5,
//                       color: Colors.white
//                   ),
//                 ),
//                 child: const FinanceCard(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //等待widget初始化完成
//     WidgetsBinding.instance.addPostFrameCallback((duration) {
//       //通过key获取到widget的位置
//       if(iconKey.currentContext != null){
//         RenderBox box = iconKey.currentContext?.findRenderObject() as RenderBox;
//         //获取widget的高宽
//         iconSize = box.size;
//         //获取位置
//         iconOffset = box.localToGlobal(Offset.zero);
//       }
//     });
//     return Header(
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//       backgroundColor: ColorConstant.transparentColor,
//       leadingWidth: (14 + 82),
//       leading: Container(
//         padding: const EdgeInsets.only(left: 14).r,
//         child: Row(
//           children: <Widget>[
//             MyImage(
//               src: 'assets/platform/home/icon_logo_nor.png',
//               width: 82,
//               height: 32,
//               onPressed: () {
//                 if (userStore.isSignIn) {
//                   onPathLine(context);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         Container(
//           padding: const EdgeInsets.only(right: 14).r,
//           child: userStore.isSignIn
//               ? _signInView(context)
//               : _unSignInView(context),
//         )
//       ],
//     );
//   }
//
//   Widget _unSignInView(BuildContext context) {
//     return Row(
//       children: [
//         Button(
//           height: 24,
//           width: 54,
//           fontSize: 13,
//           text: '注册',
//           onPressed: () => routerUtil.onPushSignUp(context),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 10.r),
//           child: Button(
//               type: ButtonType.text,
//               height: 24,
//               width: 54,
//               fontSize: 13,
//               onPressed: () => routerUtil.onPushSignIn(context),
//               text: '登录'),
//         ),
//         InkWell(
//           onTap: routerUtil.onPushCustomer,
//           child: Padding(
//             padding: EdgeInsets.only(left: 14.r),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const MyImage(
//                   src: 'assets/platform/home/customer_service.png',
//                   width: 24,
//                 ),
//                 Text(
//                   '客服',
//                   style:
//                   TextStyle(fontSize: 12.sp, color: ColorConstant.whiteColor),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget _signInView(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Observer(builder: (_){
//                   UserInfo userInfo = userStore.userInfo;
//                   return VipIcon(
//                     level: userInfo.level - 1,
//                     blackImage: true,
//                   );
//                 }),
//                 SizedBox(width: 6.r,),
//                 Observer(builder: (_) {
//                   return Text(
//                     userStore.username!,
//                     style: TextStyle(
//                         fontSize: 14.sp,
//                         fontFamily: 'DIN Pro',
//                         fontWeight: FontWeight.w700,
//                         color: ColorConstant.normalColor),
//                   );
//                 }),
//               ],
//             ),
//             Observer(
//               builder: (_) {
//                 BalanceInfo balanceInfo = userStore.balanceInfo;
//                 return Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/home/financeCard/icon_centralbar_rmb.png.webp',
//                       width: 8,
//                       color: ColorConstant.whiteColor,
//                     ),
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(2, 0, 2, 3).r,
//                       child: Text(numberFormat(balanceInfo.balance),
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontFamily: 'DIN Pro',
//                             fontWeight: FontWeight.w700,
//                             color: ColorConstant.whiteColor,
//                           )),
//                     )
//                   ],
//                 );
//               },
//             )
//           ],
//         ),
//         SizedBox(
//           width: 14.r,
//         ),
//         InkWell(
//           onTap: ()=>showModel(context),
//           child: Column(
//             key: iconKey,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const MyImage(
//                 src: 'assets/platform/home/financeCard/top_more.png',
//                 width: 20,
//               ),
//               Text(
//                 '更多',
//                 style: TextStyle(fontSize: 12.sp),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
// }
