import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:credit_card_x/credit_card_x.dart';

void main() {
  testWidgets('CreditCardX shows card number and can flip',
      (WidgetTester tester) async {
    final controller = CardFlipController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CreditCardX(
          cardNumber: '4242 4242 4242 4242',
          expiryDate: '10/29',
          cvv: '123',
          showCvv: true,
          providerLogo: const SizedBox.shrink(),
          enableFlip: true,
          background: const CardBackground.solid(Color(0xFF1E88E5)),
          controller: controller,
        ),
      ),
    ));

    expect(find.textContaining('4242'), findsOneWidget);

    // flip
    controller.toggle();
    await tester.pumpAndSettle();
    // CVV is on back; since CardBack displays '***' by default when showCvv true it will show cvv on back
    expect(find.text('123'), findsOneWidget);
  });
}
