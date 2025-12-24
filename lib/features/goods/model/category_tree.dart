import 'package:coolmall_flutter/features/main/model/home_data.dart';

/// 分类树结构
class CategoryTree {
  final int id;
  final String name;
  final int? parentId;
  final int sortNum;
  final String? pic;
  final int status;
  final String? createTime;
  final String? updateTime;
  final List<CategoryTree> children;

  CategoryTree({
    required this.id,
    required this.name,
    this.parentId,
    required this.sortNum,
    this.pic,
    required this.status,
    this.createTime,
    this.updateTime,
    this.children = const [],
  });

  /// 从Category转换为CategoryTree
  static CategoryTree fromCategory(Category category) {
    return CategoryTree(
      id: category.id,
      name: category.name ?? '',
      parentId: category.parentId,
      sortNum: category.sortNum,
      pic: category.pic,
      status: category.status,
      createTime: category.createTime.toIso8601String(),
      updateTime: category.updateTime.toIso8601String(),
    );
  }

  /// 创建一个新的CategoryTree对象，替换children字段
  CategoryTree copyWith({List<CategoryTree>? children}) {
    return CategoryTree(
      id: id,
      name: name,
      parentId: parentId,
      sortNum: sortNum,
      pic: pic,
      status: status,
      createTime: createTime,
      updateTime: updateTime,
      children: children ?? this.children,
    );
  }
}
