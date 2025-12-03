
import 'package:coolmall_flutter/features/main/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute homeRoute = GoRoute(
  path: AppRoutes.home,
  pageBuilder: (context, state) =>
      MaterialPage(key: state.pageKey, child: const HomePage()),
);