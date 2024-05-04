import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String image;
  final String recipeName;
  final String cookingTime;
  final bool isFavorite;

  const RecipeCard({
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
        SizedBox(height: 6),
        Center(
          child: Container(
            width: width * 0.92,
            height: height * 0.46,
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
                Positioned(
                  child: Container(
                    width: width * 0.92,
                    height: height * 0.34,

                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                ),
                Positioned(
                  top: height * 0.38,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: width * 0.92,
                    child: Column(
                      children: [
                        Text(
                          recipeName,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
                                      color: Color(0xFFFF6E41),
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'In Favorites',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF5E5E5E),
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.05),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Color(0xFFFF6E41),
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    cookingTime,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF5E5E5E),
                                      fontSize: 13,
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
                  top: height * 0.3,
                  left: width * 0.027,
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
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.023),
      ],
    );
  }
}
