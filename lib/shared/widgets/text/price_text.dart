import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';

/// 价格文本组件
/// @param price 价格数值，例如 4999
/// @param color 自定义颜色，默认为主题色
/// @param modifier 修饰符
/// @param integerTextStyle 整数部分文本样式，默认为标题中号
/// @param decimalTextStyle 小数部分文本样式，默认为正文中号
/// @param symbolTextStyle 人民币符号文本样式，默认为正文中号
class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.price,
    this.color = colorDanger,
    this.integerTextSize,
    this.decimalTextSize,
    this.symbolTextSize,
  });

  /// 价格数值，例如 4999
  final int price;

  /// 自定义颜色，默认为主题色
  final Color color;

  /// 整数部分文本样式，默认为标题中号
  final double? integerTextSize;

  /// 小数部分文本样式，默认为正文中号
  final double? decimalTextSize;

  /// 人民币符号文本样式，默认为正文中号
  final double? symbolTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // 人民币符号
        Text(
          '¥',
          style: TextStyle(color: color, fontSize: symbolTextSize ?? 12),
        ),

        // 整数部分
        Text(
          price.toString(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: integerTextSize ?? 18,
          ),
        ),

        // 小数部分
        Text(
          '.00',
          style: TextStyle(color: color, fontSize: decimalTextSize ?? 12),
        ),
      ],
    );
  }
}
