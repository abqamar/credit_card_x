import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'card_front.dart';
import 'card_back.dart';
import 'card_background.dart';
import 'card_flip_controller.dart';
import 'card_type.dart';

/// A customizable credit/debit card widget with flip animation.
///
/// `CreditCardX` displays a styled bank card that can flip between
/// front and back sides (optionally controlled by a [CardFlipController]).
///
/// ### Features:
/// - Provider logo on the **top-left** (asset or network image).
/// - Currency widget + balance on the **top-right**.
/// - Optional NFC / Tap-to-Pay icon on the **middle-right**.
/// - Card number with masking/unmasking support.
/// - Expiry date on bottom-left.
/// - Card type image (Visa, Mastercard, Amex) on bottom-right.
/// - Back side with CVV (masked/unmasked).
/// - Gradient or solid background support.
/// - Tap-to-flip animation, or external flip control.
///
/// Example usage:
/// ```dart
/// CreditCardX(
///   providerLogo: Image.asset('assets/bank_logo.png', height: 40),
///   currencyWidget: const Text('USD'),
///   balance: 1200.50,
///   cardNumber: '1234 5678 9012 3456',
///   expiryDate: '10/29',
///   cvv: '123',
///   cardType: CardType.visa,
/// )
/// ```
class CreditCardX extends StatefulWidget {
  // ───────────────────────────────── FRONT PROPERTIES ──────────────────────────────

  /// Logo widget displayed at the **top-left** of the card.
  /// Example: `Image.asset(...)` or `Image.network(...)`.
  final Widget? providerLogo;

  /// Widget displayed at the **top-right** of the card,
  /// usually showing currency (e.g., `Text('USD')`).
  final Widget? currencyWidget;

  /// Optional balance value shown next to [currencyWidget].
  final double? balance;

  /// Whether to display the NFC / Tap-to-Pay icon
  /// on the **middle-right** of the card.
  final bool showNfcIcon;

  /// The full card number.
  /// Displayed masked unless [showFullCardNumber] is true.
  final String cardNumber;

  /// Whether to show the full [cardNumber] (true),
  /// or mask it with `**** **** **** 1234` (false).
  final bool showFullCardNumber;

  /// Expiry date shown on the bottom-left (e.g., "10/29").
  final String expiryDate;

  /// Card brand type (Visa, Mastercard, Amex).
  /// Displays brand logo on bottom-right.
  final CardType? cardType;

  // ───────────────────────────────── BACK PROPERTIES ──────────────────────────────

  /// The 3–4 digit CVV code shown on the back of the card.
  final String cvv;

  /// Whether to show the actual [cvv] (true),
  /// or mask it with `***` (false).
  final bool showCvv;

  // ───────────────────────────────── VISUALS & BEHAVIOR ──────────────────────────

  /// Custom text style for displaying [balance].
  final TextStyle? balanceStyle;

  /// Whether tapping the card should flip between front and back.
  final bool enableFlip;

  /// Background style for the card (solid color or gradient).
  final CardBackground background;

  /// Card width in logical pixels. Defaults to `340`.
  final double width;

  /// Card height in logical pixels. Defaults to `200`.
  final double height;

  /// Border radius for rounded corners. Defaults to `12`.
  final double borderRadius;

  /// Whether to show balance alongside [currencyWidget].
  final bool? showBalance;

  /// External flip controller.
  /// If null, an internal controller is created.
  final CardFlipController? controller;

  /// Optional callback when card is tapped.
  final VoidCallback? onTap;

  /// Creates a [CreditCardX] widget.
  const CreditCardX({
    super.key,
    this.providerLogo,
    this.currencyWidget,
    this.balance,
    this.showNfcIcon = false,
    required this.cardNumber,
    this.showFullCardNumber = false,
    required this.expiryDate,
    this.cardType,
    this.showBalance,
    this.balanceStyle,
    required this.cvv,
    this.showCvv = false,
    this.enableFlip = true,
    this.background =
        const CardBackground.gradient([Color(0xFF1E88E5), Color(0xFF5E35B1)]),
    this.width = 340,
    this.height = 200,
    this.borderRadius = 12,
    this.controller,
    this.onTap,
  });

  @override
  State<CreditCardX> createState() => _FlipCreditCardXState();
}

class _FlipCreditCardXState extends State<CreditCardX>
    with SingleTickerProviderStateMixin {
  late final CardFlipController _internalController;
  late final AnimationController _animController;
  late final Animation<double> _animation;

  CardFlipController get _controller =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = CardFlipController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation =
        CurvedAnimation(parent: _animController, curve: Curves.easeInOut);

    // Listen to the ValueNotifier and drive the animation.
    _controller.isFront.addListener(_onFlipChanged);
  }

  void _onFlipChanged() {
    if (!mounted) return;
    if (_controller.isFront.value) {
      _animController.reverse();
    } else {
      _animController.forward();
    }
  }

  @override
  void dispose() {
    _controller.isFront.removeListener(_onFlipChanged);
    if (widget.controller == null) {
      _internalController.dispose();
    }
    _animController.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap?.call();
    if (!widget.enableFlip) return;
    _controller.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final value = _animation.value;
            final angle = value * math.pi;
            final isFrontVisible = value < 0.5;

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isFrontVisible
                  ? _buildFront()
                  : Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: _buildBack(),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront() {
    return CardFront(
      providerLogo: widget.providerLogo,
      currencyWidget: widget.currencyWidget,
      balance: widget.balance,
      showNfcIcon: widget.showNfcIcon,
      cardNumber: widget.cardNumber,
      showFullCardNumber: widget.showFullCardNumber,
      expiryDate: widget.expiryDate,
      cardType: widget.cardType,
      background: widget.background,
      showBalance: widget.showBalance ?? false,
      borderRadius: widget.borderRadius,
      balanceStyle: widget.balanceStyle,
    );
  }

  Widget _buildBack() {
    return CardBack(
      cvv: widget.cvv,
      showCvv: widget.showCvv,
      background: widget.background,
      borderRadius: widget.borderRadius,
    );
  }
}
