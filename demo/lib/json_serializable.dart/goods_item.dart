import 'package:json_annotation/json_annotation.dart';
part 'goods_item.g.dart';

@JsonSerializable()
class GoodsItem {
  @JsonKey(name: 'goods_name')
  String? goodsName;
  @JsonKey(name: 'in_time')
  String? inTime;

  GoodsItem({required this.goodsName, required this.inTime});

  /// 从JSON创建GoodsItem实例的工厂构造函数
  factory GoodsItem.fromJson(Map<String, dynamic> json) =>
      _$GoodsItemFromJson(json);

  /// 将GoodsItem实例转换为JSON的函数

  Map<String, dynamic> toJson() => _$GoodsItemToJson(this);

  // 实现SuperEntity接口的方法，这里以toString为例，具体实现根据接口定义
  @override
  String toString() {
    return 'GoodsItem{goodsName: $goodsName, inTime: $inTime}';
  }
}