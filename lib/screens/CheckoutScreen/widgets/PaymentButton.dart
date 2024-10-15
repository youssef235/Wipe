import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final String title;
  final Color color;

  PaymentButton({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: color),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
