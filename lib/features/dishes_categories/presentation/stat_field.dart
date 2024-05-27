import 'package:flutter/material.dart';
import 'package:recipes/features/all_recipes/statistics.dart';

import 'widgets/categories_screen.dart';

class StatField extends StatelessWidget {
  const StatField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Statistic(title: 'Application statistics', categories: [
      'Total registered'
          ' users:',
      'Recipes created by users:',
      'The most popular diet (last month):',
      'Most popular recipe(last month):'
    ],
        answers: [
          '200',
          '15',
          'vegetarian',
          'pumpkin soup'
        ]);
  }
}
