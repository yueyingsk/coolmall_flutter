import 'package:coolmall_flutter/core/network/http_constants.dart';
import 'package:coolmall_flutter/core/network/network_service.dart';
import 'package:coolmall_flutter/features/goods/model/goods_page_data.dart';
import 'package:coolmall_flutter/features/goods/model/goods_search_request.dart';

class GoodsRepository {
  Future<GoodsPageData> getGoodsPage(GoodsSearchRequest request) async {
    // print(request.toMap());
    final response = await networkService.post(
      HttpConstans.GOODS_PAGE,
      data: request.toMap(),
    );
    // print(response);
    return GoodsPageData.fromJson(response);
  }
}

final goodsRepository = GoodsRepository();
