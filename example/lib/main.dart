import 'package:flutter/material.dart';
import 'package:credit_card_x/credit_card_x.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('CreditCardX Example')),
        body: const Center(child: ExamplePage()),
      ),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final controller = CardFlipController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CreditCardX(
          cardNumber: '5242424242424242',
          expiryDate: '10/29',
          cvv: '123',
          showCvv: true,
          providerLogo: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png',
              height: 20),
          enableFlip: true,
          background: const CardBackground.gradient(
              [Color(0xFF1E88E5), Color(0xFF1E88E5)]),
          showBalance: true,
          showNfcIcon: true,
          balance: 1250.50,
          currencyWidget: Text(
            'USD',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
          cardType: CardType.visa,
          controller: controller,
          showFullCardNumber: true,
          balanceStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
