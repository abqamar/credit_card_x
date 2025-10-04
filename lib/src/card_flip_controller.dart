import 'package:flutter/foundation.dart';

/// A controller to manage the flipping state of a credit card widget.
///
/// This class is typically used with a [CreditCardX] widget to control whether
/// the front or back side of the card is displayed.
///
/// The controller exposes a [ValueListenable] so that widgets can reactively
/// listen to flip state changes.
///
/// Example:
/// ```dart
/// final controller = CardFlipController();
///
/// // Flip to the back side
/// controller.showBack();
///
/// // Flip to the front side
/// controller.showFront();
///
/// // Toggle between front/back
/// controller.toggle();
/// ```
class CardFlipController {
  /// Internal state notifier that tracks whether the card is showing the front.
  final ValueNotifier<bool> _isFront = ValueNotifier<bool>(true);

  /// A [ValueListenable] that provides the current flip state of the card.
  ///
  /// - `true`: front side of the card is visible.
  /// - `false`: back side of the card is visible.
  ///
  /// This can be listened to with a [ValueListenableBuilder] for reactive UI updates.
  ValueListenable<bool> get isFront => _isFront;

  /// Toggles the card side.
  ///
  /// If the card is currently showing the front, it will flip to the back,
  /// and vice versa.
  void toggle() => _isFront.value = !_isFront.value;

  /// Forces the card to display its **front side**.
  void showFront() => _isFront.value = true;

  /// Forces the card to display its **back side**.
  void showBack() => _isFront.value = false;

  /// Disposes the internal [ValueNotifier].
  ///
  /// Call this when the controller is no longer needed to free resources.
  void dispose() => _isFront.dispose();
}
