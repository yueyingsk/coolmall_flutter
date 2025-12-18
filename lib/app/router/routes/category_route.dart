import 'package:coolmall_flutter/features/main/views/category_page.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute categoryRoute = GoRoute(
  path: AppRoutes.category,
  builder: (context, state) => const CategoryPage(),
);
