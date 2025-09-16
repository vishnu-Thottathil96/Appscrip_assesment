import 'package:flutter/material.dart';
import 'package:flutter_template/core/config/routes_onfig/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
