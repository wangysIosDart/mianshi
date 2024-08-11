
import 'package:flutter/animation.dart';

extension ColorExtension on Color {
  /// 将颜色加深一定的比例，默认值为 10%
  Color darken([double amount = 0.1]) {
    int r = (red * (1 - amount)).clamp(0, 255).round();
    int g = (green * (1 - amount)).clamp(0, 255).round();
    int b = (blue * (1 - amount)).clamp(0, 255).round();
    return Color.fromARGB(alpha, r, g, b);
  }
}
