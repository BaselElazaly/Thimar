import 'package:flutter/material.dart';
import 'package:thimar/model/category_model.dart';

class CategoryBox extends StatelessWidget {
  final CategoryModel model; 
  const CategoryBox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            model.media, 
            width: screenHeight * 0.1,
            height: screenHeight * 0.1,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          model.name, 
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}