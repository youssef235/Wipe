import 'package:flutter/material.dart';

class CarDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Car: Porsche GT3',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Service: Full Wash'),
          Text('Location: Hamzah ibn Al Qasim St, Jeddah'),
          Text('Contact: 00965 54 373 9827'),
          SizedBox(height: 10),
          Text('Full Wash: 250 SAR'),
          Text('Mats Covering (2 Pcs): 8 SAR'),
          SizedBox(height: 10),
          Text(
            'Total: 258 SAR',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
