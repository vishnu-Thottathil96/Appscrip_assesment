import 'package:flutter/material.dart';
import 'package:flutter_template/core/config/routes_onfig/app_routes.dart';
import 'package:flutter_template/core/config/routes_onfig/app_screens.dart';
import 'package:flutter_template/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppScreens.splash.path, //initial route
    routes: AppRoutes.appRoutes(),
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Page not found!'))),
  );
}
