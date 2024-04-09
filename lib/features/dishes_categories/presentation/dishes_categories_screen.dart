import 'package:flutter/material.dart';

import 'widgets/categories_screen.dart';

class DishesCategories extends StatelessWidget {
  const DishesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Categories(title: 'Diets', categories: [
      'BREAKFAST',
      'SOUP',
      'SALAD',
      'DESSERT',
      'SAUCE',
      'MARINADE',
      'DRINK',
      'SNACK'
    ]);
  }
}
