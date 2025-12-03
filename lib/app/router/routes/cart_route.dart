
import 'package:coolmall_flutter/features/main/views/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute cartRoute = GoRoute(
  path: AppRoutes.cart,
  pageBuilder: (context, state) =>
      MaterialPage(key: state.pageKey, child: const CartPage()),
);