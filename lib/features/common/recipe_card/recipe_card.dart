import 'package:flutter/material.dart';
import 'package:recipes/features/approve_recipes/widgets/recipe_full_card_approve.dart';
import 'package:recipes/features/full_recipe/presentation/full_recipe_screen.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

class RecipeCard extends StatelessWidget {
  final String? image;
  final String recipeName;
  final bool isFavorite;
  final bool isUserRecipe;
  final int id;

  const RecipeCard({
    required this.image,
    required this.recipeName,
    required this.isFavorite,
    required this.id,
    required this.isUserRecipe,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final double width = size.width;
    final double height = size.height;
    return GestureDetector(
        onTap: () {
          if (userRole == 'user') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FullRecipe(recipeId: id, isUserRecipe: isUserRecipe),
              ),
            );
          } else if (userRole == 'administrator') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecipeFullCardApprove(
                      id: id,
                      isUserRecipe: true,
                    ),
              ),
            );
          }
        },
        child: Column(
          children: [
            SizedBox(height: 6),
            Center(
                child: Stack(
                  children: [
                    Column(
                        children: [
                          Container(
                              width: width * 0.92,
                              height: height * 0.34,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),

                                child: Container(
                                  width: width * 0.92,
                                  height: height * 0.344,
                                  child: image != null
                                      ? Image.network(
                                    alignment: Alignment.center,
                                    image!,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.asset(
                                    'assets/images/default_recipe.png',
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          Container(
                              constraints: BoxConstraints(
                                minHeight: 0,
                              ),
                              width: width * 0.92,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(1),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.17),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),

                              child: Column(
                                  children: [
                                    SizedBox(height: height * 0.0342),
                                    Container(
                                      padding: EdgeInsets.only(left: 40,
                                          right: 40),
                                      width: width * 0.92,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              recipeName.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF000000),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,

                                              ),

                                            ),


                                          ),
                                          Center(
                                            child: Column(
                                                children: [
                                                  if(isFavorite)
                                                    SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Visibility(
                                                        visible: isFavorite,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFFFF6E41),
                                                              size: 18,
                                                            ),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              'In Favorites',
                                                              style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                color: Color(
                                                                    0xFF5E5E5E),
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width *
                                                                    0.05),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height * 0.0342),
                                  ])
                          ),

                        ]
                    ),
                    userRole == 'user'
                        ? Positioned(
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
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                      ),
                    )
                        : SizedBox(),
                  ],
                )
            ),
            SizedBox(height: height * 0.023),
          ],
        ));
  }
}
