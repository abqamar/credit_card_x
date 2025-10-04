/// Utility functions for formatting credit card information and currency.

/// Masks or formats a credit card number.
///
/// - [number]: The raw card number string (digits only or with spaces).
/// - [mask]: If `true`, masks all digits except the last 4 (default `true`).
///
/// Returns a formatted string grouped in 4-digit sections.
/// Examples:
/// ```dart
/// maskCardNumber('4111111111111111'); // **** **** **** 1111
/// maskCardNumber('4111111111111111', mask: false); // 4111 1111 1111 1111
/// ```
String maskCardNumber(String number, {bool mask = true}) {
  final cleaned = number.replaceAll(RegExp(r'[^0-9]'), '');
  if (!mask) {
    // Format in groups of 4
    final buffer = StringBuffer();
    for (var i = 0; i < cleaned.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }

  // Mask all but last 4 digits, keep grouping
  final visible = 4;
  final buffer = StringBuffer();
  for (var i = 0; i < cleaned.length; i++) {
    if (i != 0 && i % 4 == 0) buffer.write(' ');
    if (i < cleaned.length - visible)
      buffer.write('*');
    else
      buffer.write(cleaned[i]);
  }
  return buffer.toString();
}

/// Formats an expiry date string into `MM/YY`.
///
/// - [expiry]: The raw expiry string (digits only or mixed with slashes).
///
/// If input has 4+ digits, returns first two as month and next two as year.
/// Otherwise, returns original input.
///
/// Examples:
/// ```dart
/// formatExpiry('1029'); // 10/29
/// formatExpiry('10/29'); // 10/29
/// ```
String formatExpiry(String expiry) {
  final cleaned = expiry.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleaned.length >= 4) {
    final mm = cleaned.substring(0, 2);
    final yy = cleaned.substring(2, 4);
    return '$mm/$yy';
  }
  return expiry;
}

/// Formats a currency value as a string with a symbol and 2 decimal places.
///
/// - [amount]: The numeric amount to format.
/// - [symbol]: The currency symbol (default: `$`).
///
/// Examples:
/// ```dart
/// formatCurrency(1234.5); // $1234.50
/// formatCurrency(1234.5, symbol: 'AED'); // AED1234.50
/// ```
String formatCurrency(double amount, {String symbol = '\$'}) {
  return '$symbol${amount.toStringAsFixed(2)}';
}
