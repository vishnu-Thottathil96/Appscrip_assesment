import 'package:flutter/material.dart';
import 'package:flutter_template/core/config/routes_onfig/app_routes.dart';
import 'package:flutter_template/core/config/routes_onfig/app_screens.dart';
import 'package:flutter_template/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppScreens.home.path, //initial route 
    routes: AppRoutes.appRoutes(),
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Page not found!'))),
  );
}

// Navigator Function       	                               GoRouter Equivalent

// Navigator.push	                                        context.push('/route')

// Navigator.pushReplacement	                              context.go('/route')

// Navigator.pushNamed	                                  context.push('/route')

// Navigator.pushNamedAndRemoveUntil	                      context.go('/route')

// Navigator.pushAndRemoveUntil	                            context.go('/route')

// Navigator.pop	                                                 context.pop()

// Navigator.canPop	                                            context.canPop()

// Navigator.maybePop	                                        context.maybePop()

// Navigator.popUntil	               while (context.canPop()) { context.pop(); }

// Navigator.restorablePush	                    Manual state management required
