import 'package:coolmall_flutter/app/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coolmall_flutter/app/bootstrap.dart';
import 'package:coolmall_flutter/app/router/router.dart';
import 'package:coolmall_flutter/app/theme/theme.dart';
import 'package:coolmall_flutter/shared/widgets/refresh/refresh_configuration.dart';

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
      providers: viewModels,
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
