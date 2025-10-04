import 'package:flutter/material.dart';
import 'card_background.dart';

/// A widget that renders the **back side of a credit card**.
///
/// Displays:
/// - A **black magnetic strip** (top section).
/// - A **CVV field area** (right-aligned).
/// - An optional **signature label** (bottom-right).
///
/// Supports both **solid** and **gradient** backgrounds via [CardBackground].
///
/// Example usage:
/// ```dart
/// CardBack(
///   cvv: "123",
///   showCvv: true,
///   background: CardBackground.gradient([Colors.blue, Colors.purple]),
///   borderRadius: 16,
/// )
/// ```
class CardBack extends StatelessWidget {
  /// The CVV/CVC number displayed on the card.
  ///
  /// This is usually a 3–4 digit code.
  final String cvv;

  /// Whether to display the actual [cvv] value or mask it as "***".
  ///
  /// Defaults to `false` for security.
  final bool showCvv;

  /// Background style (solid or gradient) of the card.
  final CardBackground background;

  /// Border radius for the card’s rounded corners.
  ///
  /// Defaults to `12`.
  final double borderRadius;

  /// Creates a back side of a credit card.
  const CardBack({
    Key? key,
    required this.cvv,
    this.showCvv = false,
    required this.background,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Colors.black, fontFamily: 'Courier');

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: background.decoration(borderRadius: borderRadius),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: black magnetic strip
            Container(height: 40, color: Colors.black87),
            const SizedBox(height: 12),

            // Middle: CVV field (masked or visible)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    color: Colors.white70,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      showCvv ? cvv : '***',
                      style: textStyle?.copyWith(fontFamily: 'KreditBold'),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Bottom: signature note
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Signature',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
