import 'package:coolmall_flutter/features/main/view/mine_page.dart';
import 'package:go_router/go_router.dart';

import '../app_routes.dart';

GoRoute mineRoute = GoRoute(
  path: AppRoutes.mine,
  builder: (context, state) => const MinePage(),
);
