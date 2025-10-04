import 'package:flutter/material.dart';

/// A utility class to define and generate background decorations
/// for a credit card widget.
///
/// Supports both **solid colors** and **gradients**.
///
/// Example usage:
/// ```dart
/// // Solid background
/// final solidBg = CardBackground.solid(Colors.blue);
///
/// // Gradient background
/// final gradientBg = CardBackground.gradient([Colors.purple, Colors.red]);
///
/// // Apply to a Container
/// Container(
///   decoration: solidBg.decoration(borderRadius: 16),
/// )
/// ```
class CardBackground {
  /// The gradient colors used for the card background, if any.
  final List<Color>? gradientColors;

  /// The solid color used for the card background, if any.
  final Color? solidColor;

  /// Private constructor for internal initialization.
  const CardBackground._({this.gradientColors, this.solidColor});

  /// Creates a **solid color background** for the card.
  ///
  /// Example:
  /// ```dart
  /// CardBackground.solid(Colors.black);
  /// ```
  const CardBackground.solid(Color color) : this._(solidColor: color);

  /// Creates a **gradient background** for the card.
  ///
  /// The gradient requires at least **two colors**.
  ///
  /// Example:
  /// ```dart
  /// CardBackground.gradient([Colors.blue, Colors.green]);
  /// ```
  const CardBackground.gradient(List<Color> colors)
      : this._(gradientColors: colors);

  /// Returns a [BoxDecoration] to be applied to a widget's background.
  ///
  /// If [gradientColors] is provided with at least two colors,
  /// a [LinearGradient] is applied.
  ///
  /// Otherwise, a solid color is used (defaults to [Colors.blueGrey]
  /// if no [solidColor] is specified).
  ///
  /// The [borderRadius] parameter controls the corner rounding.
  BoxDecoration decoration({double borderRadius = 12}) {
    if (gradientColors != null && gradientColors!.length >= 2) {
      return BoxDecoration(
        gradient: LinearGradient(colors: gradientColors!),
        borderRadius: BorderRadius.circular(borderRadius),
      );
    }
    return BoxDecoration(
      color: solidColor ?? Colors.blueGrey,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}
