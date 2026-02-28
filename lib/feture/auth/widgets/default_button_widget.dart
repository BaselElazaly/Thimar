// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final String text;
  final Color btnColor;
  final Color btnShadowColor;
  final VoidCallback? onPress;
  const DefaultButton(
      {super.key,
      required this.text,
      required this.btnColor,
      required this.btnShadowColor,
      required this.onPress});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.btnColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: widget.btnShadowColor.withOpacity(0.25),
              offset: const Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
