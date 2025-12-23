/// 排序类型枚举
enum SortType {
  /// 综合排序
  comprehensive,

  /// 销量排序
  sales,

  /// 价格排序
  price,
}

/// SortType扩展方法
extension SortTypeExtension on SortType {
  /// 获取排序名称
  String get name {
    switch (this) {
      case SortType.comprehensive:
        return '综合';
      case SortType.sales:
        return '销量';
      case SortType.price:
        return '价格';
    }
  }
}
