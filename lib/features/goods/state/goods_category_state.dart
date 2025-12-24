import 'package:coolmall_flutter/features/goods/model/category_tree.dart';
import 'package:coolmall_flutter/features/goods/model/goods_category_page_args.dart';
import 'package:coolmall_flutter/features/goods/model/goods_search_request.dart';
import 'package:coolmall_flutter/features/goods/repository/goods_repository.dart';
import 'package:coolmall_flutter/features/main/model/home_data.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../model/sort_state.dart';
import '../model/sort_type.dart';

class GoodsCategoryState extends ChangeNotifier {
  final RefreshController _refreshController = RefreshController();
  final GoodsSearchRequest goodsSearchRequest = GoodsSearchRequest();
  SortManagementState _sortState = const SortManagementState();
  String? _searchText;
  bool _isAppBarVisible = true;

  /// 搜索文本
  String? get searchText => _searchText;

  /// 是否显示AppBar
  bool get isAppBarVisible => _isAppBarVisible;

  /// 更新AppBar可见性
  void updateAppBarVisibility(bool isVisible) {
    if (_isAppBarVisible != isVisible) {
      _isAppBarVisible = isVisible;
      notifyListeners();
    }
  }

  ///是否为限时精选
  bool _isFeatured = false;

  /// 是否为限时精选
  bool get isFeatured => _isFeatured;

  /// 是否为推荐商品
  bool _isRecommended = false;

  /// 是否为推荐商品
  bool get isRecommended => _isRecommended;

  /// 选中的分类ID列表
  List<int>? _selectedCategoryIds;

  /// 选中的分类ID列表
  List<int>? get selectedCategoryIds => _selectedCategoryIds;

  /// 最小价格
  String? _minPrice;

  /// 最小价格
  String? get minPrice => _minPrice;

  /// 最大价格
  String? _maxPrice;

  /// 最大价格
  String? get maxPrice => _maxPrice;

  /// 初始化参数
  void initParams(GoodsCategoryPageArgs args) {
    _isFeatured = args.isFeatured;
    _isRecommended = args.isRecommended;
    _selectedCategoryIds = args.selectedCategoryIds;
    _minPrice = args.minPrice;
    _maxPrice = args.maxPrice;
    _searchText = args.searchKey ?? '';
  }

  /// 刷新控制器
  RefreshController get refreshController => _refreshController;

  /// 排序状态
  SortManagementState get sortState => _sortState;

  /// 分类是否加载完成
  bool categoryLoaded = false;

  /// 商品列表
  final List<Goods> _goods = [];
  List<Goods> get goods => _goods;

  /// 初始化数据
  Future<void> getGoodsListData() async {
    String? sortType;
    String? sortState;
    switch (_sortState.currentSortType) {
      case SortType.comprehensive:
        sortType = null;
        sortState = null;
        break;
      case SortType.price:
        sortType = "price";
        sortState = _sortState.currentSortState == SortState.asc
            ? "asc"
            : "desc";
        break;
      case SortType.sales:
        sortType = "sold";
        sortState = _sortState.currentSortState == SortState.asc
            ? "asc"
            : "desc";
        break;
    }
    await goodsRepository
        .getGoodsPage(
          goodsSearchRequest.copyWith(
            typeId: selectedCategoryIds,
            minPrice: _minPrice,
            maxPrice: _maxPrice,
            keyWord: _searchText,
            order: sortType,
            sort: sortState,
            featured: _isFeatured,
            recommend: _isRecommended,
          ),
        )
        .then((value) {
          _goods.addAll(value.list);
          if (_goods.isNotEmpty) {
            if (goodsSearchRequest.page * goodsSearchRequest.size >=
                value.pagination.total) {
              _refreshController.loadNoData();
            } else {
              goodsSearchRequest.page++;
              _refreshController.loadComplete();
            }
          }
        });
    _refreshController.refreshCompleted();
    notifyListeners();
  }

  /// 刷新数据
  Future<void> refreshData() async {
    goodsSearchRequest.page = 1;
    _goods.clear();
    await getGoodsListData();
  }

  /// 加载更多数据
  Future<void> loadMoreData() async {
    await getGoodsListData();
  }

  /// 更新排序类型
  void updateSortType(SortType sortType) {
    if (_sortState.currentSortType == sortType) {
      // 如果点击的是当前选中的排序类型，则切换排序状态
      SortState newState;
      switch (_sortState.currentSortState) {
        case SortState.none:
          newState = SortState.asc;
          break;
        case SortState.asc:
          newState = SortState.desc;
          break;
        case SortState.desc:
          newState = SortState.none;
          break;
      }
      // 如果新状态是none，则将排序类型重置为综合排序
      if (newState == SortState.none) {
        _sortState = _sortState.copyWith(
          currentSortType: SortType.comprehensive,
          currentSortState: newState,
        );
      } else {
        _sortState = _sortState.copyWith(currentSortState: newState);
      }
    } else {
      // 如果点击的是新的排序类型，则重置排序状态为升序
      _sortState = _sortState.copyWith(
        currentSortType: sortType,
        currentSortState: SortState.asc,
      );
    }
    refreshData();
  }

  /// 切换视图类型（列表/瀑布流）
  void toggleViewType() {
    _sortState = _sortState.copyWith(isListView: !_sortState.isListView);
    notifyListeners();
  }

  // /// 切换筛选弹窗显示状态
  // void toggleFilterVisible() {
  //   _sortState = _sortState.copyWith(
  //     isFilterVisible: !_sortState.isFilterVisible,
  //   );
  //   if (_sortState.isFilterVisible) {
  //     if (!categoryLoaded) {
  //       getCategoryListData();
  //     }
  //   }
  //   notifyListeners();
  // }

  /// 设置筛选弹窗显示状态
  void setFilterVisible(bool visible) {
    _sortState = _sortState.copyWith(isFilterVisible: visible);
    if (visible) {
      if (!categoryLoaded) {
        Future.delayed(const Duration(milliseconds: 340), () {
          getCategoryListData();
        });
      }
    }
    notifyListeners();
  }

  // /// 显示分类内容
  // void showCategoryContent() {
  //   if (!categoryLoaded) {
  //     getCategoryListData();
  //   }
  // }

  /// 更新搜索文本
  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  /// 执行搜索
  Future<void> performSearch() async {
    if (_searchText?.isEmpty ?? true) return;
    refreshData();
  }

  /// 分类树数据
  List<CategoryTree> _categoryTrees = [];
  List<CategoryTree> get categoryTrees => _categoryTrees;

  /// 加载分类列表数据
  Future<void> getCategoryListData() async {
    await goodsRepository.getCategoryList().then((value) {
      _categoryTrees = convertToTree(value);
      categoryLoaded = true;
      notifyListeners();
    });
  }

  /// 将Category列表转换为CategoryTree树形结构
  ///
  /// @param categories 原始分类列表
  /// @return 树形结构的分类列表
  List<CategoryTree> convertToTree(List<Category> categories) {
    // 按sortNum排序的列表
    final sortedList = categories
      ..sort((a, b) => a.sortNum.compareTo(b.sortNum));

    // 将Category转换为CategoryTree
    final categoryTrees = sortedList
        .map((category) => CategoryTree.fromCategory(category))
        .toList();

    // 找出顶级分类
    final rootCategories = <CategoryTree>[];

    // 子分类映射，key是父ID，value是子分类列表
    final childrenMap = <int, List<CategoryTree>>{};

    // 将分类按父ID分组
    for (var categoryTree in categoryTrees) {
      final parentId = categoryTree.parentId;
      if (parentId == null) {
        // 顶级分类
        rootCategories.add(categoryTree);
      } else {
        // 添加到子分类映射
        final children = childrenMap.putIfAbsent(parentId, () => []);
        children.add(categoryTree);
      }
    }

    // 递归构建树
    return rootCategories.map((rootCategory) {
      return buildCategoryTree(rootCategory, childrenMap);
    }).toList();
  }

  /// 递归构建分类树
  ///
  /// @param categoryTree 当前分类树节点
  /// @param childrenMap 子分类映射
  /// @return 构建好的分类树
  CategoryTree buildCategoryTree(
    CategoryTree categoryTree,
    Map<int, List<CategoryTree>> childrenMap,
  ) {
    final children = childrenMap[categoryTree.id] ?? [];

    // 如果没有子分类，直接返回
    if (children.isEmpty) {
      return categoryTree;
    }

    // 递归构建每个子分类的树
    final childrenTree = children.map((child) {
      return buildCategoryTree(child, childrenMap);
    }).toList();

    // 创建一个新的CategoryTree对象，包含子分类列表
    return categoryTree.copyWith(children: childrenTree);
  }

  /// 应用筛选
  void applyFilters(
    List<int> selectedCategoryIds,
    String minPrice,
    String maxPrice,
  ) {
    _selectedCategoryIds = selectedCategoryIds;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    refreshData();
  }

  /// 重置筛选
  void resetFilters() {
    _selectedCategoryIds = null;
    _minPrice = null;
    _maxPrice = null;
    refreshData();
  }
}
