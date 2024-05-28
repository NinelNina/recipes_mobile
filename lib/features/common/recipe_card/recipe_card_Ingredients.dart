import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/features/favourite_button.dart';

import '../widgets/custom_toggle_button.dart';

class RecipeCardIngredients extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  final String readyInMinutes;
  final bool isFavouriteRecipe;
  final List<Ingredient> extendedIngredients;
  final List<String>? steps;

  const RecipeCardIngredients({
    required this.id,
    required this.image,
    required this.title,
    required this.readyInMinutes,
    required this.isFavouriteRecipe,
    required this.extendedIngredients,
    required this.steps,
  });

  @override
  _RecipeCardIngredientsState createState() => _RecipeCardIngredientsState();
}

class _RecipeCardIngredientsState extends State<RecipeCardIngredients> {
  int selectedIndex = 0;
  int portions = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Column(
      children: [
        SizedBox(height: height * 0.026),
        Stack(
          children: [
            Container(
              height: height * 0.452,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      width: width * 0.92,
                      height: height * 0.381,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.395,
                    //bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      //padding: EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "cooking time",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF000000),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.009),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: width * 0.01),
                                  Text(
                                    widget.readyInMinutes,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF000000),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: height * 0.341,
                    right: width * 0.078,
                    child: FavoritesButton(index: widget.id),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.008),
        CustomToggleButton(extendedIngredients: widget.extendedIngredients, steps: widget.steps),
      ],
    );
  }
}
