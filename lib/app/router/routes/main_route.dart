import 'package:coolmall_flutter/features/main/state/main_state.dart';
import 'package:coolmall_flutter/features/main/views/main_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';

// 定义主页面路由
final mainRoute = GoRoute(
  path: AppRoutes.main,
  builder: (context, state) => ChangeNotifierProvider(
    create: (_) => MainState(),
    child: const MainPage(),
  ),
);