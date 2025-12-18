import 'package:coolmall_flutter/app/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 全局状态管理类都需要在这里添加
final List<SingleChildWidget> states = [
  // 导航栏状态管理
  ChangeNotifierProvider(create: (_) => AppState()),
];

// 页面级状态管理类不再在这里注册，而是在各自的页面中注册
