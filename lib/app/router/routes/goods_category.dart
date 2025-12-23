import 'package:coolmall_flutter/features/goods/model/goods_category_page_args.dart';
import 'package:coolmall_flutter/features/goods/state/goods_category_state.dart';
import 'package:coolmall_flutter/features/goods/view/goods_category_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';

GoRoute goodsCategoryRoute = GoRoute(
  path: AppRoutes.goodsCategory,
  builder: (context, state) => ChangeNotifierProvider(
    create: (context) =>
        GoodsCategoryState()..initParams(state.extra as GoodsCategoryPageArgs),
    child: const GoodsCategoryPage(),
  ),
);
