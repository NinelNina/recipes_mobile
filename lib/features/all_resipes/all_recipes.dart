import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';

class All_recipes extends StatelessWidget {
  final List<String> recipes = [
    'Recipe 1',
    'Recipe 2',
    'Recipe 3',
    'Recipe 4',
    'Recipe 5',
  ];

  final List<String> images = [
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
  ];

  final List<bool> isFavorite = [
    true,
    false,
    false,
    false,
    false,
  ];

  final List<String> cookingTime = [
    '30 min',
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerItem(icon: Icons.home, text: 'Home'),
              DrawerItem(icon: Icons.list, text: 'All recipes'),
              DrawerItem(icon: Icons.category, text: 'Categories'),
              DrawerItem(icon: Icons.fastfood, text: 'Diets'),
              DrawerItem(icon: Icons.person, text: 'User recipes'),
              DrawerItem(icon: Icons.login, text: 'Login'),
              SizedBox(height: 31.59),
            ],
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              TopRow(),
              Expanded(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeCard(
                      image: images[index],
                      recipeName: recipes[index],
                      cookingTime: cookingTime[index],
                      isFavorite: isFavorite[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}