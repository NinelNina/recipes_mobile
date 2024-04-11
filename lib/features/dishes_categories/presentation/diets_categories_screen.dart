import 'package:flutter/material.dart';

import 'widgets/categories_screen.dart';

class DietsCategories extends StatelessWidget {
  const DietsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Categories(title: 'Diets', categories: [
      'VEGETARIAN',
      'GLUTEN FREE',
      'PALEO',
      'VEGAN',
      'KETOGENIC'
    ]);
  }
}
