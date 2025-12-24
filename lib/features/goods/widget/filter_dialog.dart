import 'package:coolmall_flutter/features/goods/state/goods_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/features/goods/model/category_tree.dart';

/// 分类卡片组件
class _CategoryCard extends StatefulWidget {
  final CategoryTree category;
  final Set<int> selectedCategoryIds;
  final void Function(int) onToggleCategory;
  final BuildContext context;

  const _CategoryCard({
    required this.category,
    required this.selectedCategoryIds,
    required this.onToggleCategory,
    required this.context,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        color: Theme.of(widget.context).colorScheme.surfaceContainerHigh,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(widget.context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              if (widget.category.children.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.category.children.map((child) {
                    final isSelected = widget.selectedCategoryIds.contains(
                      child.id,
                    );
                    return _buildCategoryChip(
                      context: widget.context,
                      category: child,
                      isSelected: isSelected,
                      onTap: () {
                        widget.onToggleCategory(child.id);
                      },
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // 构建分类选择标签
  Widget _buildCategoryChip({
    required BuildContext context,
    required CategoryTree category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final borderColor = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;
    final backgroundColor = isSelected
        ? Theme.of(context).colorScheme.primary.withAlpha(26) // 0.1 opacity
        : Theme.of(context).colorScheme.surface;
    final textColor = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 如果有图片，显示图片
            if (category.pic != null && category.pic!.isNotEmpty) ...[
              NetworkImageWidget(
                imageUrl: category.pic!,
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              category.name,
              style: TextStyle(fontSize: 12, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// 筛选弹窗组件
class FilterDialog extends StatefulWidget {
  final void Function()? onClose;
  final void Function()? onAnimationEnd;
  final Offset buttonOffset;
  final List<CategoryTree> categoryData;
  final List<int> selectedCategoryIds;
  final String minPrice;
  final String maxPrice;
  final void Function(List<int> categoryIds, String minPrice, String maxPrice)?
  onApplyFilters;
  final void Function()? onResetFilters;

  const FilterDialog({
    super.key,
    this.onClose,
    this.onAnimationEnd,
    required this.buttonOffset,
    required this.categoryData,
    this.selectedCategoryIds = const [],
    this.minPrice = '',
    this.maxPrice = '',
    this.onApplyFilters,
    this.onResetFilters,
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

  // 价格区间状态
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  // 选中的分类ID集合
  late Set<int> _selectedCategoryIds;

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

  // 重置筛选条件
  void _resetFilters() {
    setState(() {
      _minPriceController.text = '';
      _maxPriceController.text = '';
      _selectedCategoryIds.clear();
    });
    widget.onResetFilters?.call();
  }

  // 应用筛选条件
  void _applyFilters() {
    widget.onApplyFilters?.call(
      _selectedCategoryIds.toList(),
      _minPriceController.text,
      _maxPriceController.text,
    );
    closeWithAnimation();
  }

  // 切换分类选择状态
  void _toggleCategory(int categoryId) {
    setState(() {
      if (_selectedCategoryIds.contains(categoryId)) {
        _selectedCategoryIds.remove(categoryId);
      } else {
        _selectedCategoryIds.add(categoryId);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // 初始化价格控制器
    _minPriceController = TextEditingController(text: widget.minPrice);
    _maxPriceController = TextEditingController(text: widget.maxPrice);
    // 初始化选中的分类ID集合
    _selectedCategoryIds = Set<int>.from(widget.selectedCategoryIds);

    // 延迟执行动画，确保组件已经加载
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _scale = 1.0;
        _backgroundOpacity = 0.5;
      });
    });
  }

  @override
  void dispose() {
    // 释放控制器资源
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FilterDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategoryIds != oldWidget.selectedCategoryIds) {
      setState(() {
        _selectedCategoryIds = Set<int>.from(widget.selectedCategoryIds);
      });
    }
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
          left: widget.buttonOffset.dx * 2,
          width: MediaQuery.of(context).size.width - widget.buttonOffset.dx * 4,
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
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  // 标题栏
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.all(12),
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
                          onTap: closeWithAnimation,
                          child: SvgPicture.asset(
                            'assets/drawable/ic_close.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurface,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 筛选内容列表
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        // 价格区间
                        SliverToBoxAdapter(
                          child: RepaintBoundary(
                            child: Card(
                              elevation: 0,
                              margin: const EdgeInsets.all(12),
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHigh,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '价格区间',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        // 最低价输入框
                                        Expanded(
                                          child: _buildPriceInputField(
                                            controller: _minPriceController,
                                            placeholder: '最低价',
                                          ),
                                        ),
                                        // 分隔线
                                        Container(
                                          width: 16,
                                          height: 1,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.outline,
                                        ),
                                        // 最高价输入框
                                        Expanded(
                                          child: _buildPriceInputField(
                                            controller: _maxPriceController,
                                            placeholder: '最高价',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 分类筛选
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final category = widget.categoryData[index];
                            return _CategoryCard(
                              category: category,
                              selectedCategoryIds: _selectedCategoryIds,
                              onToggleCategory: _toggleCategory,
                              context: context,
                            );
                          }, childCount: widget.categoryData.length),
                        ),
                      ],
                    ),
                  ),
                  // 底部操作按钮
                  Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 32,
                            child: OutlinedButton(
                              onPressed: _resetFilters,
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              child: const Text('重置'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 32,
                            child: ElevatedButton(
                              onPressed: _applyFilters,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                '确定',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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

  // 构建价格输入框
  Widget _buildPriceInputField({
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        maxLines: 1,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}
