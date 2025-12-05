import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coolmall_flutter/app/bootstrap.dart';
import 'package:coolmall_flutter/app/router/router.dart';
import 'package:coolmall_flutter/app/theme/theme.dart';
import 'package:coolmall_flutter/features/main/viewmodel/nav_bar_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bootstrap.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 导航栏状态管理
        ChangeNotifierProvider(create: (_) => NavBarViewModel()),
        // 可以在这里添加更多的状态管理类
      ],
      child: MaterialApp.router(
        title: 'CoolMall',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
