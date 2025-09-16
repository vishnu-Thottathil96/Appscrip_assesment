import 'package:flutter_template/domain/models/user_model.dart';
import 'package:flutter_template/presentation/home_screen/home_screen.dart';
import 'package:flutter_template/presentation/splash_screen/splash_screen.dart';
import 'package:flutter_template/presentation/user_details_screen/user_details_screen.dart';
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
      GoRoute(
        path: AppScreens.UserDetailsPage.path,
        name: AppScreens.UserDetailsPage.routeName,

        builder: (context, state) {
          final user = state.extra as UserModel;

          return UserDetailsPage(user: user);
        },
      ),
    ];
  }
}
