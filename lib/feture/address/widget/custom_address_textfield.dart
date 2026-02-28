import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/utils/app_colors.dart';

class CustomAddressTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Color fillColor;
  final int maxLine;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CustomAddressTextField({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    this.isPassword = false,
    this.fillColor = Colors.white,
    this.maxLine = 1,
  });

  @override
  State<CustomAddressTextField> createState() => _CustomAddressTextFieldState();
}

class _CustomAddressTextFieldState extends State<CustomAddressTextField> {
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          hasText = widget.controller.text.isNotEmpty;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                blurRadius: 17,
                color: Colors.black.withOpacity(0.05))
          ]),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) {
          setState(() {
            hasText = value.isNotEmpty;
          });
        },
        maxLines: widget.maxLine,
        obscureText: widget.isPassword,
        style: const TextStyle(
          fontFamily: 'Tajawal',
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: widget.textInputType,
        cursorColor: Colors.grey[700],
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8B8B8B),
              fontWeight: FontWeight.w300),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          filled: true,
          fillColor: hasText ? const Color(0xFFF9FFF0) : widget.fillColor,
          contentPadding: const EdgeInsetsDirectional.symmetric(
              vertical: 18, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: hasText ? AppColors.primary : Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: hasText ? AppColors.primary : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
