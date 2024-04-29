import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipes/features/all_resipes/recipe_ingredients.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/%D1%81ustomDrawer.dart';
import 'package:recipes/features/main_page/main_batton.dart';
import 'package:recipes/features/main_page/recipeCardRandom.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';

import '../all_resipes/all_recipes.dart';
import '../common/recipe_card/recipe_card_Ingredients.dart';
import '../common/top_row/top_bar.dart';
import '../common/widgets/menu_icon_widget.dart';
import '../dishes_categories/presentation/diets_categories_screen.dart';
import '../dishes_categories/presentation/dishes_categories_screen.dart';
import '../nav_bar_text_favorites.dart';
import '../sing_in/presentation/sign_in_screen.dart';

class MainPage extends StatelessWidget {
  final List<String> recipes = [
    'Recipe 1',
    'Recipe 2',
    'Recipe 3',
    'Recipe 4',
    'Recipe 5',
  ];

  final List<String> images = [
    'assets/images/imageRecipe.jpeg',
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
            NavBarWithTextAndFavorites(
              title: 'Main page',
              navWidget: MenuIconWidget(width: width),
              width: width,
              height: height,
            ),
            SizedBox(height: 35),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recipe_ingredients(
                            count: index,
                            image: images[index],
                            recipeName: recipes[index],
                            cookingTime: cookingTime[index],
                            isFavorite: isFavorite[index],
                          ),
                        ),
                      );
                    },
                    child: RecipeCardRandom(
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
