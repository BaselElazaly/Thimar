import 'package:flutter/material.dart';
import 'package:thimar/core/utils/app_colors.dart';

class CountryCodeWidget extends StatefulWidget {
  const CountryCodeWidget({super.key});

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isActive = !isActive;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12,),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFF9FFF0) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isActive ? AppColors.primary : const Color(0xFFF3F3F3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/saudi_flag.png', width: 32), 
            const SizedBox(height: 4),
            const Text(
              "+966",
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w500,
                color: AppColors.primary, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}