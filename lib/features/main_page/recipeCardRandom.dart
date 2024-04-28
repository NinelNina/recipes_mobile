import 'package:flutter/material.dart';

import 'main_batton.dart';
import 'main_battons_four.dart';

class RecipeCardRandom extends StatelessWidget {
  final String image;
  final String recipeName;
  final String cookingTime;
  final bool isFavorite;

  const RecipeCardRandom({
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
    return Column(
      children: [
        Center(
          child: Container(
            width: 377,
            height: 465,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.17),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  width: 377,
                  height: 53,
                  child: Center(
                    child: Text("Случайный рецепт"),
                  ),
                ),
                Positioned(
                  top: 53,
                  child: Container(
                    width: 377,
                    height: 307,
                    child: Image.asset(
                      alignment: Alignment.center,
                      image,
                    ),
                  ),
                ),
                Positioned(
                  top: 390.5,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 377,
                    child: Column(
                      children: [
                        Text(
                          recipeName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: isFavorite,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'In Favorites',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    cookingTime,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 325,
                  left: 10.91,
                  child: Container(
                    width: 65.09,
                    height: 65,
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
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        MainButtons(),
      ],
    );
  }
}
