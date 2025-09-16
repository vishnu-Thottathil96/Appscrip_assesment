import 'package:flutter/material.dart';

/// Defines supported device categories.
enum ScreenType { phone, tablet, desktop }

/// Defines supported orientation types.
enum OrientationType { portrait, landscape }

/// Base dimensions for responsive scaling (e.g. iPhone 14 Pro).
class ResponsiveConstants {
  static const double baseWidth = 393.0;
  static const double baseHeight = 852.0;
}

/// A utility class to handle responsive design and scaling across devices.
class ResponsiveHelper {
  ResponsiveHelper._(); // private constructor

  /// Returns the screen type (phone, tablet, desktop) based on width.
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return ScreenType.desktop;
    if (width >= 600) return ScreenType.tablet;
    return ScreenType.phone;
  }

  /// Returns the orientation type (portrait or landscape).
  static OrientationType getOrientationType(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? OrientationType.portrait
        : OrientationType.landscape;
  }

  /// Returns a responsive value based on screen type.
  static double getResponsiveValue({
    required BuildContext context,
    required double phone,
    double? tablet,
    double? desktop,
  }) {
    switch (getScreenType(context)) {
      case ScreenType.tablet:
        return tablet ?? phone;
      case ScreenType.desktop:
        return desktop ?? tablet ?? phone;
      default:
        return phone;
    }
  }

  /// Device type checkers.
  static bool isPhone(BuildContext context) =>
      getScreenType(context) == ScreenType.phone;
  static bool isTablet(BuildContext context) =>
      getScreenType(context) == ScreenType.tablet;
  static bool isDesktop(BuildContext context) =>
      getScreenType(context) == ScreenType.desktop;

  /// Orientation checkers.
  static bool isPortrait(BuildContext context) =>
      getOrientationType(context) == OrientationType.portrait;
  static bool isLandscape(BuildContext context) =>
      getOrientationType(context) == OrientationType.landscape;

  /// Returns screen width.
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Returns screen height.
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Returns text size based on screen width and system text scaling.
  static double getTextSize(BuildContext context, {double scale = 0.03}) {
    final screenWidth = getWidth(context);
    final textScale = MediaQuery.of(context).textScaleFactor;
    return screenWidth * scale * textScale;
  }

  /// Scales a width value relative to the base width.
  static double scaleWidth(BuildContext context, double referenceWidth,
      {double baseWidth = ResponsiveConstants.baseWidth}) {
    final screenWidth = getWidth(context);
    return (referenceWidth / baseWidth) * screenWidth;
  }

  /// Scales a height value relative to the base height.
  static double scaleHeight(BuildContext context, double referenceHeight,
      {double baseHeight = ResponsiveConstants.baseHeight}) {
    final screenHeight = getHeight(context);
    return (referenceHeight / baseHeight) * screenHeight;
  }

  /// Returns scaled symmetric padding.
  static EdgeInsets scalePadding(BuildContext context,
      {double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(
      horizontal: scaleWidth(context, horizontal),
      vertical: scaleHeight(context, vertical),
    );
  }

  /// Returns scaled margin.
  static EdgeInsets scaleMargin(BuildContext context,
      {double left = 0,
      double top = 0,
      double right = 0,
      double bottom = 0,
      double horizontal = 0,
      double vertical = 0}) {
    return EdgeInsets.only(
      left: left > 0 ? scaleWidth(context, left) : scaleWidth(context, horizontal),
      right: right > 0 ? scaleWidth(context, right) : scaleWidth(context, horizontal),
      top: top > 0 ? scaleHeight(context, top) : scaleHeight(context, vertical),
      bottom: bottom > 0 ? scaleHeight(context, bottom) : scaleHeight(context, vertical),
    );
  }

  /// Returns scaled vertical spacing (gap).
  static double scaleGap(BuildContext context, double referenceGap,
      {double baseHeight = ResponsiveConstants.baseHeight}) {
    return scaleHeight(context, referenceGap, baseHeight: baseHeight);
  }

  /// Returns scaled border radius.
  static double scaleRadius(BuildContext context, double referenceRadius,
      {double baseWidth = ResponsiveConstants.baseWidth}) {
    return scaleWidth(context, referenceRadius, baseWidth: baseWidth);
  }
}
