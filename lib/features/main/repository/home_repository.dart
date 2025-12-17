import 'package:coolmall_flutter/core/network/http_constants.dart';
import 'package:coolmall_flutter/core/network/network_service.dart';
import 'package:coolmall_flutter/features/main/models/home_data.dart';

class HomeRepository {
  /// 获取首页数据
  Future<HomeData> getHomeData() async {
    final response = await networkService.get(HttpConstans.PAGE_HOME);
    return HomeData.fromJson(response);
  }
}

final homeRepository = HomeRepository();
