import 'dart:io';

import 'package:coolmall_flutter/app/state/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coolmall_flutter/app/bootstrap.dart';
import 'package:coolmall_flutter/app/router/router.dart';
import 'package:coolmall_flutter/app/theme/theme.dart';
import 'package:coolmall_flutter/shared/widgets/refresh/refresh_configuration.dart';

// 运行指令解决web跨域问题
// flutter run -d edge --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bootstrap.initialize();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: states,
      child: AppRefreshConfiguration(
        child: MaterialApp.router(
          title: 'CoolMall',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
