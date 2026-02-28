// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryBox extends StatefulWidget {
  final String boxText;
  final String svgPath;
  final Color boxColor1;
  final Color boxColor2;
  const CategoryBox({
    super.key,
    required this.boxText,
    required this.svgPath,
    required this.boxColor1,
    required this.boxColor2,
  });

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: screenHeight * 0.1,
          height: screenHeight * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                  color: const Color(0xFFECF5E3).withOpacity(0.3)),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                widget.boxColor1,
                widget.boxColor2,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              widget.svgPath,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          widget.boxText,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}