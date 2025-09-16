enum AppScreens { splash, error, home, UserDetailsPage }

extension AppRouteExtension on AppScreens {
  String get path => '/$name';
  String get routeName => name;
}
