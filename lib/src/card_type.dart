import 'package:flutter/widgets.dart';

/// Supported credit/debit card types.
///
/// Used to determine which card brand logo to display on the card widget.
enum CardType { visa, mastercard, amex }

/// A helper class for working with [CardType].
///
/// Provides methods to get the appropriate logo widget for a card type
/// and to detect the card type from a card number.
///
/// Example usage:
/// ```dart
/// final type = CardTypeHelper.detectFromNumber('4111 1111 1111 1111'); // visa
/// final logo = CardTypeHelper.widgetFor(type!);
/// ```
class CardTypeHelper {
  /// Returns a [Widget] representing the card logo for a given [CardType].
  ///
  /// - [type]: The type of card (visa, mastercard, amex).
  /// - [height]: Optional height for the logo container (default 28).
  ///
  /// The logo images are loaded from assets:
  /// - `assets/Visa_Logo.png`
  /// - `assets/Mastercard-Logo.png`
  /// - `assets/Amex.png`
  static Widget widgetFor(CardType type, {double height = 28}) {
    switch (type) {
      case CardType.visa:
        return SizedBox(
          height: height,
          child: Center(
            child: Image.asset(
              "assets/Visa_Logo.png",
              height: 22,
            ),
          ),
        );
      case CardType.mastercard:
        return SizedBox(
          height: height,
          child: Center(
            child: Image.asset(
              "assets/Mastercard-Logo.png",
              height: 28,
            ),
          ),
        );
      case CardType.amex:
        return SizedBox(
          height: height,
          child: Center(
            child: Image.asset(
              "assets/Amex.png",
              height: 25,
            ),
          ),
        );
    }
  }

  /// Naive helper to detect [CardType] from a card number.
  ///
  /// - `4` → Visa
  /// - `5` → Mastercard
  /// - `34` or `37` → Amex
  ///
  /// Returns `null` if the type cannot be determined.
  ///
  /// Example:
  /// ```dart
  /// final type = CardTypeHelper.detectFromNumber('4111 1111 1111 1111'); // visa
  /// ```
  static CardType? detectFromNumber(String number) {
    final cleaned = number.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return null;
    if (cleaned.startsWith('4')) return CardType.visa;
    if (cleaned.startsWith('5')) return CardType.mastercard;
    if (cleaned.startsWith('34') || cleaned.startsWith('37'))
      return CardType.amex;
    return null;
  }
}
