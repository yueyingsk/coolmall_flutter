
import 'package:coolmall_flutter/features/main/views/mine_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute mineRoute = GoRoute(
  path: AppRoutes.mine,
  pageBuilder: (context, state) =>
      MaterialPage(key: state.pageKey, child: const MinePage()),
);