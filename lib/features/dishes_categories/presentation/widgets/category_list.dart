import 'package:flutter/material.dart';
import 'category_field.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final double width;
  final double height;

  const CategoryList(
      {super.key,
      required this.categories,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.map((category) {
        return Column(children: [


             CategoryField(
              text: category,
              height: height,
              width: width,
            ),
          SizedBox(height: height * 0.28)
        ]);
      }).toList(),
    );
  }
}
