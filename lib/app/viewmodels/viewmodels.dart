import 'package:coolmall_flutter/features/launch/viewmodel/guide_viewmodel.dart';
import 'package:coolmall_flutter/features/launch/viewmodel/splash_viewmodel.dart';
import 'package:coolmall_flutter/features/main/viewmodel/nav_bar_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 所有的状态管理类都需要在这里添加
final List<SingleChildWidget> viewModels = [
  //splash页面状态管理
  ChangeNotifierProvider(create: (_) => SplashViewModel()),
  // 引导页状态管理
  ChangeNotifierProvider(create: (_) => GuideViewModel()),
  // 导航栏状态管理
  ChangeNotifierProvider(create: (_) => NavBarViewModel()),
];
