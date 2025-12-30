import 'package:coolmall_flutter/app/router/app_routes.dart';
import 'package:coolmall_flutter/features/common/model/web_view_data.dart';
import 'package:coolmall_flutter/features/common/state/web_view_state.dart';
import 'package:coolmall_flutter/features/common/view/web_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRoute webRoute = GoRoute(
  path: AppRoutes.web,
  builder: (context, state) => ChangeNotifierProvider(
    create: (context) => WebViewState()..initParams(state.extra as WebViewData),
    child: const WebPage(),
  ),
);
