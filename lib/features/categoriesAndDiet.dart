import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/all_resipes/recipe_ingredients.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/%D1%81ustomDrawer.dart';

import 'common/top_row/top_bar.dart';
import 'common/widgets/menu_icon_widget.dart';
import 'nav_bar_with_favorites.dart';

class CategoriesAndDiens extends StatelessWidget {
  final List<String> images;
  final List<String> recipes;
  final List<String> cookingTime;
  final List<bool> isFavorite;

  CategoriesAndDiens({
    required this.images,
    required this.recipes,
    required this.cookingTime,
    required this.isFavorite,
  });



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
              title: '1',
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
