import 'package:flutter/material.dart';

import 'PaymentButton.dart';

class PaymentMethodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Select Payment Method',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        PaymentButton(title: 'Apple Pay', color: Colors.white),
        PaymentButton(title: 'VISA', color: Colors.white),
        PaymentButton(title: 'Mastercard', color: Colors.white),
      ],
    );
  }
}
