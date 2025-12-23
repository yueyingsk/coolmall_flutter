import 'package:coolmall_flutter/features/goods/model/sort_state.dart';
import 'package:coolmall_flutter/features/goods/model/sort_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 筛选栏组件
class FilterBar extends StatelessWidget {
  final SortType currentSortType;
  final SortState currentSortState;
  final bool filtersVisible;
  final ValueChanged<SortType>? onSortClick;
  final VoidCallback? onFiltersClick;
  final VoidCallback? onToggleLayout;
  final bool isGridLayout;
  final bool isAppBarVisible;
  final GlobalKey? filterButtonKey;

  const FilterBar({
    super.key,
    required this.currentSortType,
    required this.currentSortState,
    this.filtersVisible = false,
    this.onSortClick,
    this.onFiltersClick,
    this.onToggleLayout,
    this.isGridLayout = true,
    this.isAppBarVisible = true,
    this.filterButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 筛选按钮 - 与Compose代码保持一致，当filtersVisible为true时隐藏
            AnimatedOpacity(
              opacity: filtersVisible ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: GestureDetector(
                key: filterButtonKey,
                onTap: onFiltersClick,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/drawable/ic_filter.svg',
                        width: 14,
                        height: 14,
                        colorFilter: ColorFilter.mode(
                          Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        '筛选',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 排序按钮
            _buildFilterButton(
              context,
              '综合',
              currentSortType == SortType.comprehensive,
              () {
                onSortClick?.call(SortType.comprehensive);
              },
            ),

            _buildSortButtonWithArrows(
              context,
              '销量',
              SortType.sales,
              currentSortType,
              currentSortState,
              onSortClick,
            ),

            _buildSortButtonWithArrows(
              context,
              '价格',
              SortType.price,
              currentSortType,
              currentSortState,
              onSortClick,
            ),

            // 占位符，将布局切换按钮推到最右侧
            Expanded(child: const Spacer()),

            // 布局切换按钮
            AnimatedScale(
              scale: isAppBarVisible ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: GestureDetector(
                onTap: onToggleLayout,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SvgPicture.asset(
                    isGridLayout
                        ? 'assets/drawable/ic_menu_list.svg'
                        : 'assets/drawable/ic_menu.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建通用筛选按钮
  Widget _buildFilterButton(
    BuildContext context,
    String text,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surface,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  /// 构建带箭头的排序按钮
  Widget _buildSortButtonWithArrows(
    BuildContext context,
    String text,
    SortType sortType,
    SortType currentSortType,
    SortState currentSortState,
    ValueChanged<SortType>? onSortClick,
  ) {
    // 与Compose代码保持一致，只有当排序状态不是NONE时才认为是选中状态
    final bool isSelected =
        currentSortType == sortType && currentSortState != SortState.none;
    return GestureDetector(
      onTap: () => onSortClick?.call(sortType),
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surface,
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            _buildSortArrows(
              context,
              sortType,
              currentSortType,
              currentSortState,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建排序箭头
  Widget _buildSortArrows(
    BuildContext context,
    SortType sortType,
    SortType currentSortType,
    SortState currentSortState,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/drawable/ic_up_triangle.svg',
          width: 3,
          height: 3,
          colorFilter: ColorFilter.mode(
            currentSortType == sortType && currentSortState == SortState.asc
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 2),
        SvgPicture.asset(
          'assets/drawable/ic_down_triangle.svg',
          width: 3,
          height: 3,
          colorFilter: ColorFilter.mode(
            currentSortType == sortType && currentSortState == SortState.desc
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
