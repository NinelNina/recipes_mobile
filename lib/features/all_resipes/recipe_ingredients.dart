import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/recipe_card/recipe_card_Ingredients.dart';
import 'package:recipes/features/common/top_row/top_bar2.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/top_row/top_row_back.dart';

import '../common/widgets/back_icon_widget.dart';
import '../common/widgets/menu_icon_widget.dart';
import '../nav_bar_title.dart';

class Recipe_ingredients extends StatelessWidget {
  final int count;
  final String image;
  final String recipeName;
  final String cookingTime;
  final bool isFavorite;

  Recipe_ingredients({
    required this.count,
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
              NavBarTitle
                (title: recipeName,
                  navWidget: BackIconWidget(width: width),
                  width: width,
                  height: height),

              Expanded(

                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeCardIngredients(
                      index: count,
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
