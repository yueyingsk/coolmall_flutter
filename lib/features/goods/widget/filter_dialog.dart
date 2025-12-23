import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 筛选弹窗组件
class FilterDialog extends StatefulWidget {
  final void Function()? onConfirm;
  final void Function()? onReset;
  final void Function()? onClose;
  final void Function()? onAnimationEnd;
  final Offset buttonOffset;

  const FilterDialog({
    super.key,
    this.onConfirm,
    this.onReset,
    this.onClose,
    this.onAnimationEnd,
    required this.buttonOffset,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  // 缩放动画状态，从0.0到1.0
  double _scale = 0.0;
  // 背景透明度动画状态，从0.0到0.5
  double _backgroundOpacity = 0.0;
  // 标记是否正在关闭
  bool _isClosing = false;

  // 模拟筛选选项数据
  final List<Map<String, dynamic>> _filterOptions = [
    {
      'title': '品牌',
      'options': ['品牌A', '品牌B', '品牌C', '品牌D', '品牌E'],
      'selected': <String>[],
    },
    {
      'title': '价格区间',
      'options': ['0-99', '100-199', '200-299', '300-499', '500+'],
      'selected': <String>[],
    },
    {
      'title': '颜色',
      'options': ['红色', '蓝色', '绿色', '黑色', '白色'],
      'selected': <String>[],
    },
    {
      'title': '尺寸',
      'options': ['S', 'M', 'L', 'XL', 'XXL'],
      'selected': <String>[],
    },
  ];

  // 带动画的关闭方法
  void closeWithAnimation() {
    if (_isClosing) return;
    _isClosing = true;

    // 反向执行所有动画
    setState(() {
      _scale = 0.0;
      _backgroundOpacity = 0.0;
    });
  }

  @override
  void initState() {
    super.initState();

    // 延迟执行动画，确保组件已经加载
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _scale = 1.0;
        _backgroundOpacity = 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 在FilterDialog内部使用Stack包含背景和弹窗内容
    return Stack(
      children: [
        // 半透明背景层
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: _isClosing ? Curves.easeIn : Curves.easeOut,
          opacity: _backgroundOpacity,
          child: GestureDetector(
            onTap: closeWithAnimation,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
        // 弹窗内容
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: _isClosing ? Curves.easeIn : Curves.easeOut,
          top: widget.buttonOffset.dy,
          left: widget.buttonOffset.dx,
          width: MediaQuery.of(context).size.width - widget.buttonOffset.dx * 2,
          height:
              MediaQuery.of(context).size.height - widget.buttonOffset.dy * 2,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: _isClosing ? Curves.easeIn : Curves.easeOut,
            scale: _scale,
            // 设置缩放原点为筛选按钮位置
            alignment: Alignment.topLeft,
            // 动画结束回调
            onEnd: () {
              if (_isClosing) {
                widget.onAnimationEnd?.call();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 弹窗标题和关闭按钮
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '筛选',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            closeWithAnimation();
                          },
                          child: SvgPicture.asset(
                            'assets/drawable/ic_close.svg',
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurface,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 分割线
                  Divider(
                    height: 0.5,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  // 筛选内容列表
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: _filterOptions.map((group) {
                          return _buildFilterGroup(group);
                        }).toList(),
                      ),
                    ),
                  ),
                  // 底部操作按钮
                  Divider(
                    height: 0.5,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              widget.onReset?.call();
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: const Text('重置'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onConfirm?.call();
                              closeWithAnimation();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('确定'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterGroup(Map<String, dynamic> group) {
    final selected = group['selected'] as List<String>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group['title'] as String,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (group['options'] as List<String>).map((option) {
            final isSelected = selected.contains(option);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selected.remove(option);
                  } else {
                    selected.add(option);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
