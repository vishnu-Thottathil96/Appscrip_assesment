enum AppScreens { splash, error, home }

extension AppRouteExtension on AppScreens {
  String get path => '/$name';
  String get routeName => name;
}
