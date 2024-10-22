import 'package:demo/nestedScrollView/typeNav/color.dart';
import 'package:demo/nestedScrollView/typeNav/extension.dart';
import 'package:flutter/material.dart';

class SportTypeNav extends StatefulWidget {
  const SportTypeNav({
    super.key,
    required this.list,
    this.height = 40.0,
    this.onChange,
  });

  final List<String> list;
  final double height;
  final ValueChanged<String>? onChange;

  @override
  SportTypeNavState createState() => SportTypeNavState();
}

class SportTypeNavState extends State<SportTypeNav> {

 int _index = 0;

  // 返回条目
  Widget renderItem(String value,int index) {

    return InkWell(
      onTap: () {
        setState(() {
          _index = index;
        });
      },
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _index == index ? Colors.green : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: _index == index
                ? ColorConstant.whiteColor
                : ColorConstant.negativeColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 如果传入空
    if (widget.list.isEmpty) {
      return const SizedBox();
    }
    return Expanded(
      child: Container(
        height: widget.height,
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          child: Wrap(
            children: widget.list.mapIndexed((e,i) => renderItem(e,i)).toList(),
          ),
        ),
      ),
    );
  }
}
