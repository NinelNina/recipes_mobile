import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/all_recipes/recipe_ingredients.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';

import 'common/top_row/top_bar.dart';
import 'common/widgets/menu_icon_widget.dart';
import 'nav_bar_title.dart';
import 'nav_bar_with_favourites.dart';

class User_recipes extends StatelessWidget {
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
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      drawer: CustomDrawer(),

      body: SafeArea(
        child: Column(
          children: [
            NavBarWithFavorites(
              title: 'User recipes',
              navWidget: MenuIconWidget(width: width),
              width: width,
              height: height,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Recipe_ingredients(
                                count: index,
                                image: images[index],
                                recipeName: recipes[index],
                                cookingTime: cookingTime[index],
                                isFavorite: isFavorite[index],
                              ),
                        ),
                      );
                    },
                    child: RecipeCard(
                      image: images[index],
                      recipeName: recipes[index],
                      cookingTime: cookingTime[index],
                      isFavorite: isFavorite[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}