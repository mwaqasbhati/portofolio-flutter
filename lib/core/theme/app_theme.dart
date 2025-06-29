import 'package:flutter/material.dart';

/// Central location for application colors, fonts and styles.
class AppTheme {
  const AppTheme._();

  /// Primary seed color for the app color scheme.
  static const Color primaryColor = Colors.deepPurple;

  /// Color used by shimmer placeholders.
  static const Color shimmerBaseColor = Color(0xFFE0E0E0); // grey.shade300

  /// Highlight color used by shimmer placeholders.
  static const Color shimmerHighlightColor = Color(0xFFF5F5F5); // grey.shade100

  /// Background color of the balance header.
  static Color headerBackground(BuildContext context) =>
      colorSchemeOf(context).surfaceVariant;

  /// Retrieve the material color scheme for the given context.
  static ColorScheme colorSchemeOf(BuildContext context) =>
      Theme.of(context).colorScheme;

  /// Convenience accessor for the background color of the current theme.
  static Color backgroundColor(BuildContext context) =>
      colorSchemeOf(context).background;

  /// Convenience accessor for the onSurface color of the current theme.
  static Color onSurfaceColor(BuildContext context) =>
      colorSchemeOf(context).onSurface;

  /// Button background color.
  static const Color buttonColor = Colors.blue;

  /// Application wide color scheme generated from [primaryColor].
  static final ColorScheme colorScheme =
      ColorScheme.fromSeed(seedColor: primaryColor);

  /// Color scheme used when the platform requests a dark theme.
  static final ColorScheme darkColorScheme =
      ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark);

  /// Default font family used throughout the app.
  static const String fontFamily = 'Roboto';

  /// Bold text style used for short labels.
  static const TextStyle boldText = TextStyle(fontWeight: FontWeight.bold);

  /// Style for the net value displayed in the header.
  static const TextStyle headerValueStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  /// Complete material theme for the application.
  static ThemeData get theme => ThemeData(
        colorScheme: colorScheme,
        fontFamily: fontFamily,
        useMaterial3: true,
      );

  /// Theme used when the platform requests a dark appearance.
  static ThemeData get darkTheme => ThemeData(
        colorScheme: darkColorScheme,
        fontFamily: fontFamily,
        useMaterial3: true,
      );
}
