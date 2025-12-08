import 'package:coolmall_flutter/app/router/routes/guide_route.dart';
import 'package:coolmall_flutter/app/router/routes/main_route.dart';
import 'package:coolmall_flutter/app/router/routes/splash_route.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // 闪屏页路由
    splashRoute,
    // 引导页路由
    guideRoute,
    // 主路由（包含底部导航栏）
    mainShell,
  ],
);
