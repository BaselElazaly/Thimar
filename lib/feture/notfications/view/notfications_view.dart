import 'package:flutter/material.dart';

class NotficationsView extends StatelessWidget {
  const NotficationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Notfications',
          style: TextStyle(
            fontSize: 32
          ),
        ),
      ),
    );;
  }
}