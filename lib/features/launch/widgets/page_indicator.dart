import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';

/// 页面指示器组件
class PageIndicator extends StatelessWidget {
  /// 总页数
  final int pageCount;

  /// 当前页面索引
  final int currentPage;

  /// 选中指示器宽度
  final double selectedWidth;

  /// 未选中指示器宽度
  final double unselectedWidth;

  /// 指示器高度
  final double height;

  /// 指示器颜色
  final Color color;

  /// 指示器间距
  final double spacing;

  const PageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
    this.selectedWidth = 24.0,
    this.unselectedWidth = 8.0,
    this.height = 8.0,
    this.color = primaryDefault,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isSelected = index == currentPage;

        return Row(
          children: [
            // 指示器
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isSelected ? selectedWidth : unselectedWidth,
              height: height,
              decoration: BoxDecoration(
                color: isSelected
                    ? color
                    : color.withValues(alpha: 0.4), // 选中和未选中的透明度
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),

            // 最后一个指示器后面不需要间距
            if (index < pageCount - 1) SizedBox(width: spacing),
          ],
        );
      }),
    );
  }
}
