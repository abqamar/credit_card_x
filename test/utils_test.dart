import 'package:flutter_test/flutter_test.dart';
import 'package:credit_card_x/src/utils.dart';

void main() {
  test('formatCardNumber masks correctly', () {
    final out = maskCardNumber('4242424242424242', mask: true);
    expect(out.split(' ').length, 4);
    expect(out.endsWith('4242'), true);
  });

  test('formatExpiry produces MM/YY', () {
    expect(formatExpiry('1029'), '10/29');
    expect(formatExpiry('10/29'), '10/29');
  });

  test('formatCurrency formats with 2 decimals', () {
    expect(formatCurrency(12.5), '\$12.50');
  });
}
