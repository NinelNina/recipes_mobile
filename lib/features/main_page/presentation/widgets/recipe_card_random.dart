import 'package:flutter/material.dart';

import 'main_button.dart';
import 'main_buttons_four.dart';

class RecipeCardRandom extends StatelessWidget {
  final String image;
  final String recipeName;
  final bool isFavorite;

  const RecipeCardRandom({
    required this.image,
    required this.recipeName,
    required this.isFavorite,
  });


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    bool favorite = isFavorite;
    return Column(
      children: [
        Center(
          child: Container(
            width: width * 0.92,
            height: height * 0.52,
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
                  width: width * 0.92,
                  height: height * 0.059,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE0D7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text("Random recipe",
                    style: TextStyle(
                      color: Color(0xFFFF6E41),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.059,
                  child: Container(
                    width: width * 0.92,
                    height: height * 0.344,
                    child: Image.network(
                      alignment: Alignment.center,
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.437,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: width * 0.92,
                    child: Column(
                      children: [
                        Text(
                          recipeName,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.009),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: favorite,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Color(0xFFFF6E41),
                                      size: 18,
                                    ),
                                    SizedBox(width: width * 0.0097),
                                    Text(
                                      'In favorites',
                                      style: TextStyle(
                                        color: Color(0xFF5E5E5E),
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 0.049),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.364,
                  left: width * 0.026,

                  child: Container(
                    width: width * 0.158,
                    height: height * 0.073,
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
                      favorite ? Icons.favorite : Icons.favorite_border,
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
