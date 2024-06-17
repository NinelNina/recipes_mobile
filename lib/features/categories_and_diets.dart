import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/full_recipe/presentation/full_recipe_screen.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';

import 'common/top_row/top_bar.dart';
import 'common/widgets/menu_icon_widget.dart';
import 'common/widgets/nav_bar_with_favourites.dart';

class CategoriesAndDiets extends StatelessWidget {
  final List<String> images;
  final List<String> recipes;
  final List<String> cookingTime;
  final List<bool> isFavorite;

  //TODO: интегрировать Bloc complexSearch
  CategoriesAndDiets({
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
              isUserRecipe: false,
              //diet: ,
              //type: ,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeCard(
                      image: images[index],
                      recipeName: recipes[index],
                      isFavorite: isFavorite[index],
                      id: index, isUserRecipe: true,
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
