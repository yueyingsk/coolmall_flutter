import 'package:coolmall_flutter/features/main/state/home_state.dart';
import 'package:coolmall_flutter/features/main/views/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';

GoRoute homeRoute = GoRoute(
  path: AppRoutes.home,
  builder: (context, state) => ChangeNotifierProvider(
    create: (_) => HomeState(),
    child: const HomePage(),
  ),
);
