import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/all_resipes/recipe_ingredients.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/%D1%81ustomDrawer.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';
import 'package:recipes/features/user_recipes.dart';

import 'all_resipes/all_recipes.dart';
import 'appBar.dart';
import 'common/top_row/top_bar.dart';
import 'common/widgets/menu_icon_widget.dart';
import 'common/widgets/submit_button1.dart';
import 'dishes_categories/presentation/diets_categories_screen.dart';
import 'dishes_categories/presentation/dishes_categories_screen.dart';
import 'fevourites.dart';
import 'main_page/main_page.dart';

class MyRecipes extends StatelessWidget {
  final List<String> recipes = [
    'res1'
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
    return  Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              NavBarWithAddAndSearch(
                title: 'My recipes',
                navWidget: MenuIconWidget(width: width),
                width: width,
                height: height,
              ),
              Expanded(
                child: recipes.isEmpty
                    ? Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          Text('There\'s nothing here :('),
                          SizedBox(height: height * 0.04),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your button action here
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              child: Text('Add Recipe'),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: recipes.length + 1,
                        // добавляем единицу, чтобы включить кнопку
                        itemBuilder: (BuildContext context, int index) {
                          if (index == recipes.length) {
                            // это последний элемент, возвращаем кнопку
                            return Container(
                              width: width * 0.76,
                              height: height * 0.06,
                            );
                          } else {
                            // это не последний элемент, возвращаем RecipeCard
                            return Column(
                              children: [
                                Center(
                                  child: RecipeCard(
                                    image: images[index],
                                    recipeName: recipes[index],
                                    cookingTime: cookingTime[index],
                                    isFavorite: isFavorite[index],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
    );
  }
}
