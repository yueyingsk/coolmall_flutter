
import 'package:coolmall_flutter/features/main/views/category_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute categoryRoute = GoRoute(
  path: AppRoutes.category,
  pageBuilder: (context, state) =>
      MaterialPage(key: state.pageKey, child: const CategoryPage()),
);