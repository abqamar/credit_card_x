import 'package:flutter/material.dart';
import 'card_background.dart';
import 'card_type.dart';
import 'utils.dart';

/// The **front side** of a [CreditCardX].
///
/// Displays:
/// - Top-left: Provider logo (e.g., bank logo).
/// - Top-right: Currency and optional balance.
/// - Middle: Chip image + optional NFC/Tap icon.
/// - Second-last row: Card number (masked/unmasked).
/// - Bottom-left: Expiry date.
/// - Bottom-right: Card type logo (Visa, Mastercard, Amex).
/// - Bottom-center: Cardholder name.
///
/// You usually don't use [CardFront] directly — it is built internally by [CreditCardX].
class CardFront extends StatelessWidget {
  /// Logo widget displayed at the **top-left** (e.g., bank logo).
  final Widget? providerLogo;

  /// Widget displayed at the **top-right**, usually currency (e.g., `Text('USD')`).
  final Widget? currencyWidget;

  /// Optional balance value shown next to [currencyWidget].
  final double? balance;

  /// Whether to show the NFC / Tap-to-Pay icon in the **middle-right**.
  final bool showNfcIcon;

  /// The card number (will be masked unless [showFullCardNumber] is true).
  final String cardNumber;

  /// If true, the full [cardNumber] is shown. Otherwise masked with `**** **** **** 1234`.
  final bool showFullCardNumber;

  /// Whether to show balance alongside [currencyWidget].
  final bool showBalance;

  /// Expiry date in `MM/YY` format.
  final String expiryDate;

  /// Card type (Visa, Mastercard, Amex).
  final CardType? cardType;

  /// Background style (solid color or gradient).
  final CardBackground background;

  /// Border radius for rounded corners.
  final double borderRadius;

  /// Custom text style for [balance].
  final TextStyle? balanceStyle;

  /// Creates the front face of a [CreditCardX].
  const CardFront({
    super.key,
    this.providerLogo,
    this.currencyWidget,
    this.balance,
    this.showNfcIcon = false,
    required this.cardNumber,
    this.showFullCardNumber = false,
    required this.expiryDate,
    this.cardType,
    this.showBalance = false,
    required this.background,
    this.borderRadius = 12,
    this.balanceStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleSmall =
        Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70);
    final textStyleMedium =
        Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white);
    final textStyleLarge = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          letterSpacing: 2,
          fontFamily: 'Courier',
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: background.decoration(borderRadius: borderRadius),
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // ─── Top Row: Logo + Balance ────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                providerLogo ?? const SizedBox.shrink(),
                if (showBalance)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      currencyWidget ?? const SizedBox.shrink(),
                      if (balance != null)
                        Text(
                          " ${balance?.toStringAsFixed(2) ?? '0.00'}",
                          style: balanceStyle,
                        ),
                    ],
                  ),
              ],
            ),

            const Expanded(child: SizedBox()),

            // ─── Middle Row: Chip + NFC Icon ─────────────────────────────
            Row(
              children: [
                const SizedBox(width: 15),
                Image.asset(
                  "assets/chip.png",
                  height: 30,
                ),
                const Spacer(),
                if (showNfcIcon)
                  Align(
                    alignment: Alignment.centerRight,
                    child: RotatedBox(
                      quarterTurns: 225,
                      child: Icon(
                        Icons.wifi_outlined,
                        color: Colors.white70,
                        size: 25,
                      ),
                    ),
                  ),
              ],
            ),

            if (!showNfcIcon) const SizedBox(height: 6),

            const SizedBox(height: 8),

            // ─── Card Number ─────────────────────────────────────────────
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                maskCardNumber(cardNumber, mask: !showFullCardNumber),
                style: textStyleLarge?.copyWith(fontFamily: 'KreditBold'),
              ),
            ),

            // ─── Expiry ─────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'VALID\nTHRU',
                  style: textStyleSmall?.copyWith(
                    fontFamily: 'Kredit',
                    height: 1,
                    fontSize: 9,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  " ${formatExpiry(expiryDate)}",
                  style: textStyleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kredit',
                  ),
                ),
              ],
            ),

            // ─── Last Row: Cardholder Name + Card Type ──────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Muhammad Basit Qamar".toUpperCase(),
                    style: textStyleMedium?.copyWith(fontFamily: 'Kredit'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (cardType != null) CardTypeHelper.widgetFor(cardType!),
                const SizedBox(width: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
