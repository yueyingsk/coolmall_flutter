import 'sort_type.dart';

/// 排序状态枚举
enum SortState {
  /// 未选中
  none,

  /// 升序
  asc,

  /// 降序
  desc,
}

/// 排序相关状态管理类
class SortManagementState {
  /// 当前排序类型
  final SortType currentSortType;

  /// 当前排序状态
  final SortState currentSortState;

  /// 是否显示筛选弹窗
  final bool isFilterVisible;

  /// 是否为列表视图（true）或瀑布流视图（false）
  final bool isListView;

  /// 构造函数
  const SortManagementState({
    this.currentSortType = SortType.comprehensive,
    this.currentSortState = SortState.none,
    this.isFilterVisible = false,
    this.isListView = false,
  });

  /// 复制方法，用于更新状态
  SortManagementState copyWith({
    SortType? currentSortType,
    SortState? currentSortState,
    bool? isFilterVisible,
    bool? isListView,
  }) {
    return SortManagementState(
      currentSortType: currentSortType ?? this.currentSortType,
      currentSortState: currentSortState ?? this.currentSortState,
      isFilterVisible: isFilterVisible ?? this.isFilterVisible,
      isListView: isListView ?? this.isListView,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SortManagementState &&
        other.currentSortType == currentSortType &&
        other.currentSortState == currentSortState &&
        other.isFilterVisible == isFilterVisible &&
        other.isListView == isListView;
  }

  @override
  int get hashCode {
    return currentSortType.hashCode ^
        currentSortState.hashCode ^
        isFilterVisible.hashCode ^
        isListView.hashCode;
  }
}
