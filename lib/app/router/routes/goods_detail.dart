import 'package:coolmall_flutter/app/router/app_routes.dart';
import 'package:coolmall_flutter/features/goods/state/goods_detail_state.dart';
import 'package:coolmall_flutter/features/goods/view/goods_detail_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRoute goodsDetailRoute = GoRoute(
  path: AppRoutes.goodsDetail,
  builder: (context, state) => ChangeNotifierProvider(
    create: (context) => GoodsDetailState()..initParams(state.extra as int),
    child: const GoodsDetailPage(),
  ),
);
