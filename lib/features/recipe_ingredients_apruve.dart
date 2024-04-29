import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/recipe_card/recipe_card_Ingredients.dart';
import 'package:recipes/features/common/top_row/top_bar2.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/top_row/top_row_back.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';

class Recipe_ingredients_approval extends StatelessWidget {
  final String image;
  final String recipeName;
  final String cookingTime;
  final bool isFavorite;

  Recipe_ingredients_approval({
    required this.image,
    required this.recipeName,
    required this.cookingTime,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Bar2(title: recipeName, navWidget: MenuIconWidget(width: width), width: width, height: height),
           Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RecipeCardIngredients(
                      index: 1,
                      image: image,
                      recipeName: recipeName,
                      cookingTime: cookingTime,
                      isFavorite: isFavorite,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your reject button action here
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16.0),
                            ),
                            child: Icon(Icons.close,
                            color: Colors.red,),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your approve button action here
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16.0),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.green, // Set the icon color to green
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
