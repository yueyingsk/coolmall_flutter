import 'package:flutter/material.dart';
import 'package:coolmall_flutter/app/bootstrap.dart';
import 'package:coolmall_flutter/app/router/router.dart';
import 'package:coolmall_flutter/app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bootstrap.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CoolMall',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
