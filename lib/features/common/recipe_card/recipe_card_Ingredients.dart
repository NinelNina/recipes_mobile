import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_toggle_button.dart';

class RecipeCardIngredients extends StatefulWidget {
  final String image;
  final String recipeName;
  final String cookingTime;
  final bool isFavorite;

  const RecipeCardIngredients({
    required this.image,
    required this.recipeName,
    required this.cookingTime,
    required this.isFavorite,
  });

  @override
  _RecipeCardIngredientsState createState() => _RecipeCardIngredientsState();
}

class _RecipeCardIngredientsState extends State<RecipeCardIngredients> {
  List<String> ingredients = ['Item 1', 'Item 2', 'Item 3'];
  List<String> instructions = ['Step 1', 'Step 2', 'Step 3'];
  int selectedIndex = 0;
  int portions = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 404,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      height: 340,
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 352,
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
                              "Время готовки",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 4),
                                  Text(
                                    widget.cookingTime,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                    top: 304,
                    right: 32,
                    child: Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.17),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        color: Color(0xFFF40E36),
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        CustomToggleButton(),
      ],
    );
  }
}
