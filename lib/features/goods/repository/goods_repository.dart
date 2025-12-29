import 'package:coolmall_flutter/core/network/http_constants.dart';
import 'package:coolmall_flutter/core/network/network_service.dart';
import 'package:coolmall_flutter/features/goods/model/goods_category.dart';
import 'package:coolmall_flutter/features/goods/model/goods_detail.dart';
import 'package:coolmall_flutter/features/goods/model/goods_page_data.dart';
import 'package:coolmall_flutter/features/goods/model/goods_search_request.dart';
import 'package:coolmall_flutter/features/goods/model/goods_spec.dart';

class GoodsRepository {
  /// 获取商品分页数据
  Future<GoodsPageData> getGoodsPage(GoodsSearchRequest request) async {
    final response = await networkService.post(
      HttpConstans.GOODS_PAGE,
      data: request.toMap(),
    );
    return GoodsPageData.fromJson(response);
  }

  /// 获取商品分类列表
  Future<List<Category>> getCategoryList() async {
    final response = await networkService.post(HttpConstans.GOODS_CATEGORY);
    // print(response);
    return (response as List).map((e) => Category.fromJson(e)).toList();
  }

  /// 获取商品详情
  Future<GoodsDetail> getGoodsDetail(int goodsId) async {
    final response = await networkService.get(
      HttpConstans.GOODS_DETAIL,
      queryParameters: {"goodsId": goodsId},
    );
    return GoodsDetail.fromJson(response);
  }

  /// 获取商品规格列表
  Future<List<GoodsSpec>> getGoodsSpec(int goodsId) async {
    final response = await networkService.post(
      HttpConstans.GOODS_SPEC,
      data: {"goodsId": goodsId},
    );
    return (response as List).map((e) => GoodsSpec.fromJson(e)).toList();
  }
}

final goodsRepository = GoodsRepository();
