# credit_card_x

CreditCardX is a customizable Flutter package that provides a modern and interactive credit card UI component. It supports features like card flipping animations, masked card numbers, and dynamic backgrounds, making it ideal for fintech apps, payment gateways, and wallet applications.

### Note: When using Image.network for providerLogo in Flutter Web, ensure the image server allows CORS. Otherwise, prefer Image.asset for guaranteed compatibility.

## Features

- 🎨 Customizable Card Backgrounds: Choose between solid colors or gradient backgrounds.
- 🔄 Card Flip Animation: Simulate a realistic card flip between front and back views.
- 💳 Masked Card Number: Optionally mask all but the last 4 digits of the card number.
- 🧾 Expiry Date Formatting: Automatically formats expiry dates to MM/YY.
- 💰 Balance Display: Show current balance with optional currency symbol.
- 🆔 Card Type Detection: Automatically detect and display card type (Visa, Mastercard, Amex) based on card number.
- 📱 Responsive Design: Optimized for both mobile and web platforms.


## Installation

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  credit_card_x: ^0.0.1
```

## Usage
```dart
import 'package:credit_card_x/credit_card_x.dart';
```

## Quick example

```dart
CreditCardX(
  cardNumber: '5242424242424242',
  expiryDate: '10/29',
  cvv: '123',
  showCvv: true,
  providerLogo: Image.network('https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png', height: 20),
  enableFlip: true,
  background: const CardBackground.gradient([Color(0xFF1E88E5), Color(0xFF1E88E5)]),
  showBalance: true,
  balance: 1250.50,
  currencyWidget: Text('USD', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
  cardType: CardType.mastercard,
  controller: controller,
  showFullCardNumber: false,
  balanceStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
);
```
## Example App

For a complete example, check out the example/ directory in the repository.

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/abqamar/credit_card_x/blob/main/LICENSE) file for more details.

## Contributing

Contributions are welcome! Please fork the repository, create a new branch, and submit a pull request with your changes. Ensure that your code passes existing tests and includes new tests where applicable.

## Acknowledgements

- Inspired by various Flutter credit card UI packages. 
- Uses Flutter's built-in animation and decoration libraries for smooth transitions and styling.