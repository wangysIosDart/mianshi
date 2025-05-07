// 统一定义如下 mixin
import 'package:flutter/material.dart';

mixin StateAble<T extends StatefulWidget> on State<T> {
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }
}

class Adddd extends StatefulWidget {
  const Adddd({super.key});

  @override
  State<Adddd> createState() => _AddddState();
}

class _AddddState extends State<Adddd> with StateAble{
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
