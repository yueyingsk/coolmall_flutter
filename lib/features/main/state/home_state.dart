import 'package:coolmall_flutter/core/network/entity/page_info.dart';
import 'package:coolmall_flutter/features/goods/repository/goods_repository.dart';
import 'package:coolmall_flutter/features/main/models/home_data.dart';
import 'package:coolmall_flutter/features/main/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState extends ChangeNotifier {
  final RefreshController _refreshController = RefreshController();
  final PageInfo _pageInfo = PageInfo(page: 1, size: 10);

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
    if (goods.isNotEmpty && goods.length >= _pageInfo.size) {
      _pageInfo.page = 2;
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.refreshCompleted();
    notifyListeners();
  }

  /// 更多商品
  Future<void> loadMoreData() async {
    await goodsRepository.getGoodsPage(_pageInfo).then((value) {
      _goods.addAll(value.list);
      if (_pageInfo.page * _pageInfo.size >= value.pagination.total) {
        _refreshController.loadNoData();
      } else {
        _pageInfo.page++;
        _refreshController.loadComplete();
      }
    });
    notifyListeners();
  }

  /// 刷新数据
  Future<void> refreshData() async {
    _pageInfo.page = 1;
    await getHomeData();
  }
}
