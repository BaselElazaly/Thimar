import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String iconPath;
  final bool isPassword;
  final Color fillColor;
  final TextInputType textInputType;
  final TextEditingController controller;

   const CustomTextField({
    super.key,
    required this.hintText,
    required this.iconPath,
    required this.textInputType,
    required this.controller,
    this.isPassword = false, this.fillColor = Colors.white, 
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          hasText = value.isNotEmpty; 
        });
      },
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
        hintStyle: const TextStyle(color: Color(0xFFB1B1B1), fontSize: 15),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(widget.iconPath, width: 22),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
        filled: true,
        fillColor: hasText ? const Color(0xFFF9FFF0) : widget.fillColor,
        contentPadding:
            const EdgeInsetsDirectional.symmetric(vertical: 18, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: hasText ? AppColors.primary : const Color(0xFFF3F3F3),),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:  BorderSide(color: hasText ? AppColors.primary : const Color(0xFFF3F3F3),),
        ),
      ),
    );
  }
}