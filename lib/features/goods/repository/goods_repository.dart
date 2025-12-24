import 'package:coolmall_flutter/core/network/http_constants.dart';
import 'package:coolmall_flutter/core/network/network_service.dart';
import 'package:coolmall_flutter/features/goods/model/goods_page_data.dart';
import 'package:coolmall_flutter/features/goods/model/goods_search_request.dart';
import 'package:coolmall_flutter/features/main/model/home_data.dart';

class GoodsRepository {
  /// 获取商品分页数据
  Future<GoodsPageData> getGoodsPage(GoodsSearchRequest request) async {
    // print(request.toMap());
    final response = await networkService.post(
      HttpConstans.GOODS_PAGE,
      data: request.toMap(),
    );
    // print(response);
    return GoodsPageData.fromJson(response);
  }

  /// 获取商品分类列表
  Future<List<Category>> getCategoryList() async {
    final response = await networkService.post(HttpConstans.GOODS_CATEGORY);
    // print(response);
    return (response as List).map((e) => Category.fromJson(e)).toList();
  }
}

final goodsRepository = GoodsRepository();
