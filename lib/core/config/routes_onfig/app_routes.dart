import 'package:flutter_template/presentation/home_screen/home_screen.dart';
import 'package:flutter_template/presentation/splash_screen.dart/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'app_screens.dart';

class AppRoutes {
  static List<GoRoute> appRoutes() {
    return [
      GoRoute(
        path: AppScreens.splash.path,
        name: AppScreens.splash.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppScreens.home.path,
        name: AppScreens.home.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
    ];
  }
}
