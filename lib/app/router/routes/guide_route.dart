import 'package:coolmall_flutter/features/launch/views/guide_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

/// 引导页路由配置
final GoRoute guideRoute = GoRoute(
  path: AppRoutes.guide,
  pageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const GuidePage(),
  ),
);
