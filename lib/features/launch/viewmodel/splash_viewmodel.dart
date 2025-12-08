import 'package:coolmall_flutter/app/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewModel extends ChangeNotifier {
  void checkAndNavigate(BuildContext context) {
    // 先导航到引导页
    context.go(AppRoutes.guide);
  }
}
