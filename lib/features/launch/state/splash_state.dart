import 'package:coolmall_flutter/app/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashState extends ChangeNotifier {
  void checkAndNavigate(BuildContext context) {
    // 检查是否展示过引导页
    // if (!prefsUtil.getBool(
    //   LaunchConstants.keyGuideShown,
    //   defaultValue: false,
    // )) {
    //   context.go(AppRoutes.guide);
    // } else {
    //   context.go(AppRoutes.main);
    // }
    // 直接跳转到主路由
    context.go(AppRoutes.main);
  }
}
