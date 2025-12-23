import 'package:coolmall_flutter/app/router/app_routes.dart';
import 'package:coolmall_flutter/features/goods/model/goods_category_page_args.dart';
import 'package:coolmall_flutter/features/goods/model/goods_search_request.dart';
import 'package:coolmall_flutter/features/goods/repository/goods_repository.dart';
import 'package:coolmall_flutter/features/main/model/home_data.dart';
import 'package:coolmall_flutter/features/main/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState extends ChangeNotifier {
  final RefreshController _refreshController = RefreshController();
  final GoodsSearchRequest goodsSearchRequest = GoodsSearchRequest();

  RefreshController get refreshController => _refreshController;

  HomeData? _homeData;
  HomeData? get homeData => _homeData;

  //第一页全部商品
  List<Goods> _goods = [];
  List<Goods> get goods => _goods;

  /// 首页数据
  Future<void> getHomeData() async {
    _homeData = await homeRepository.getHomeData();
    //初始化首页列表
    _goods = _homeData?.goods ?? [];
    //判断是否还有更多数据
    if (goods.isNotEmpty && goods.length >= goodsSearchRequest.size) {
      goodsSearchRequest.page = 2;
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.refreshCompleted();
    notifyListeners();
  }

  /// 更多商品
  Future<void> loadMoreData() async {
    await goodsRepository.getGoodsPage(goodsSearchRequest).then((value) {
      _goods.addAll(value.list);
      if (goodsSearchRequest.page * goodsSearchRequest.size >=
          value.pagination.total) {
        _refreshController.loadNoData();
      } else {
        goodsSearchRequest.page++;
        _refreshController.loadComplete();
      }
    });
    notifyListeners();
  }

  /// 刷新数据
  Future<void> refreshData() async {
    goodsSearchRequest.page = 1;
    await getHomeData();
  }

  void toGoodsCategoryPage(BuildContext context, int id) {
    // allCategories.filter { it.parentId == parentId.toInt() }.map { it.id }
    final List<int> categoryIds =
        homeData?.categoryAll
            .where((element) => element.parentId == id)
            .map((e) => e.id)
            .toList() ??
        [];
    context.push(
      AppRoutes.goodsCategory,
      extra: GoodsCategoryPageArgs(selectedCategoryIds: categoryIds),
    );
  }
}
