import 'package:coolmall_flutter/features/launch/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute splashRoute = GoRoute(
  path: AppRoutes.splash,
  pageBuilder: (context, state) =>
      MaterialPage(key: state.pageKey, child: const SplashPage()),
);
