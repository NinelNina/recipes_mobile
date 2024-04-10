import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/recipe_card/recipe_card_Ingredients.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/top_row/top_row_back.dart';

class Recipe_ingredients extends StatelessWidget {
  final String image;
  final String recipeName;
  final String cookingTime;
  final bool isFavorite;

  Recipe_ingredients({
    required this.image,
    required this.recipeName,
    required this.cookingTime,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TopRowBack(recipeName: recipeName),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeCardIngredients(
                      image: image,
                      recipeName: recipeName,
                      cookingTime: cookingTime,
                      isFavorite: isFavorite,
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
