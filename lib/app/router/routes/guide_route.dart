import 'package:coolmall_flutter/features/launch/state/guide_state.dart';
import 'package:coolmall_flutter/features/launch/view/guide_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';

/// 引导页路由配置
final GoRoute guideRoute = GoRoute(
  path: AppRoutes.guide,
  builder: (context, state) => ChangeNotifierProvider(
    create: (_) => GuideState(),
    child: const GuidePage(),
  ),
);
