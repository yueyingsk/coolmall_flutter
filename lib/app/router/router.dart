import 'package:coolmall_flutter/app/router/routes/home_route.dart';
import 'package:go_router/go_router.dart';
import 'package:coolmall_flutter/features/main/views/main_page.dart';

import 'app_routes.dart';
import 'routes/cart_route.dart';
import 'routes/category_route.dart';
import 'routes/mine_route.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // 使用 StatefulShellRoute 实现底部导航栏持久化
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // 这里返回包含底部导航栏的主页面
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        // 主页分支
        StatefulShellBranch(routes: [homeRoute]),
        // 分类分支
        StatefulShellBranch(routes: [categoryRoute]),
        // 购物车分支
        StatefulShellBranch(routes: [cartRoute]),
        // 我的分支
        StatefulShellBranch(routes: [mineRoute]),
      ],
    ),
  ],
);
