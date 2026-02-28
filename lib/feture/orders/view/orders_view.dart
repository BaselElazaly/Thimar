import 'package:flutter/material.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Orders',
          style: TextStyle(
            fontSize: 32
          ),
        ),
      ),
    );;
  }
}