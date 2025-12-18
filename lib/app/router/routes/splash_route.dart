import 'package:coolmall_flutter/features/launch/state/splash_state.dart';
import 'package:coolmall_flutter/features/launch/views/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';

GoRoute splashRoute = GoRoute(
  path: AppRoutes.splash,
  builder: (context, state) => ChangeNotifierProvider(
    create: (_) => SplashState(),
    child: const SplashPage(),
  ),
);
