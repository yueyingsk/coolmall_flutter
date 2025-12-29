import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 星星评分组件 - 支持整星评分，带动画效果
/// @param value 当前评分值（1-5星）
/// @param count 星星总数，默认5个
/// @param size 星星大小，默认26.0
/// @param onChange 评分变化回调，为null时禁用交互
/// @param animationEnabled 是否启用动画效果，默认true
class WeRate extends StatefulWidget {
  const WeRate({
    super.key,
    required this.value,
    this.count = 5,
    this.size = 26.0,
    this.onChange,
    this.animationEnabled = true,
  });

  final int value;
  final int count;
  final double size;
  final ValueChanged<int>? onChange;
  final bool animationEnabled;

  @override
  State<WeRate> createState() => _WeRateState();
}

class _WeRateState extends State<WeRate> {
  @override
  void didUpdateWidget(WeRate oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 强制重建以更新显示
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onChange != null
          ? () {
              widget.onChange?.call(widget.value);
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.count, (index) {
          final isActive = index < widget.value;
          final starColor = isActive ? Color(0xffFF6700) : Color(0xffC0C0C0);

          return GestureDetector(
            onTap: widget.onChange != null
                ? () {
                    widget.onChange?.call(index + 1);
                  }
                : null,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              child: SvgPicture.asset(
                'assets/drawable/ic_star_fill.svg',
                width: widget.size,
                height: widget.size,
                colorFilter: ColorFilter.mode(starColor, BlendMode.srcIn),
              ),
            ),
          );
        }),
      ),
    );
  }
}
