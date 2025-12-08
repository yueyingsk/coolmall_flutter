import 'package:coolmall_flutter/features/main/views/main_page.dart';
import 'package:go_router/go_router.dart';

import 'home_route.dart';
import 'category_route.dart';
import 'cart_route.dart';
import 'mine_route.dart';

// 定义StatefulShellRoute
final mainShell = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    // 正确传递navigationShell参数
    return MainPage(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(routes: [homeRoute]),
    StatefulShellBranch(routes: [categoryRoute]),
    StatefulShellBranch(routes: [cartRoute]),
    StatefulShellBranch(routes: [mineRoute]),
  ],
);
