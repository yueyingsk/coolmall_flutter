import 'package:coolmall_flutter/features/launch/state/guide_state.dart';
import 'package:coolmall_flutter/features/launch/state/splash_state.dart';
import 'package:coolmall_flutter/features/main/state/home_state.dart';
import 'package:coolmall_flutter/features/main/state/nav_bar_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 所有的状态管理类都需要在这里添加
final List<SingleChildWidget> states = [
  //splash页面状态管理
  ChangeNotifierProvider(create: (_) => SplashState()),
  // 引导页状态管理
  ChangeNotifierProvider(create: (_) => GuideState()),
  // 导航栏状态管理
  ChangeNotifierProvider(create: (_) => NavBarState()),
  // 首页状态管理
  ChangeNotifierProvider(create: (_) => HomeState()),
];
