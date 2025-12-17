import 'package:coolmall_flutter/core/network/entity/page_info.dart';
import 'package:coolmall_flutter/core/network/http_constants.dart';
import 'package:coolmall_flutter/core/network/network_service.dart';
import 'package:coolmall_flutter/features/goods/models/goods_page_data.dart';

class GoodsRepository {
  Future<GoodsPageData> getGoodsPage(PageInfo pageInfo) async {
    final response = await networkService.post(
      HttpConstans.GOODS_PAGE,
      data: pageInfo.toMap(),
    );
    return GoodsPageData.fromJson(response);
  }
}

final goodsRepository = GoodsRepository();
