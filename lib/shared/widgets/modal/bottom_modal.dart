import 'package:flutter/material.dart';

/// 底部弹窗组件
/// 参考KT代码BottomModal设计，提供统一的底部弹窗样式和行为
class BottomModal extends StatefulWidget {
  final bool isVisible;
  final String? title;
  final VoidCallback? onDismiss;
  final Widget child;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? horizontalPadding;
  final bool showDragIndicator;

  const BottomModal({
    super.key,
    required this.isVisible,
    this.title,
    this.onDismiss,
    required this.child,
    this.backgroundColor,
    this.indicatorColor,
    this.horizontalPadding,
    this.showDragIndicator = true,
  });

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  final ScrollController _scrollController = ScrollController();
  bool _isAnimating = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BottomModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 处理可见性变化时的动画
    if (widget.isVisible != oldWidget.isVisible && widget.isVisible) {
      _isAnimating = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isAnimating = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: true,
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          snap: true,
          snapSizes: const [0.6, 0.8],
          builder: (context, scrollController) {
            // 如果我们有自己的滚动控制器，使用它；否则使用传入的
            final controller = _scrollController;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // 拖拽指示器
                  if (widget.showDragIndicator) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: widget.indicatorColor ?? Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],

                  // 标题
                  if (widget.title != null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.horizontalPadding ?? 16,
                      ),
                      child: Text(
                        widget.title!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 内容
                  Expanded(child: widget.child),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
