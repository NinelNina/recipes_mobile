import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_state.dart';
import '../../../full_recipe/presentation/full_recipe_screen.dart';
import 'main_buttons_four.dart';

class RecipeCardRandom extends StatefulWidget {
  final String? image;
  final String recipeName;
  final bool isFavorite;
  final int id;

  const RecipeCardRandom(
      {required this.image,
      required this.recipeName,
      required this.isFavorite,
      required this.id});

  @override
  State<RecipeCardRandom> createState() => _RecipeCardRandomState();
}

class _RecipeCardRandomState extends State<RecipeCardRandom> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
      if (state is FavoriteAdded && state.recipeId == widget.id) {
        setState(() {
          isFavorite = state.isFavorite;
        });
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FullRecipe(recipeId: widget.id, isUserRecipe: false),
            ),
          );
        },
        child: Column(
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
                        child: Text(
                          "Random recipe",
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
                        child: widget.image != null
                            ? Image.network(
                                alignment: Alignment.center,
                                widget.image!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/default_recipe.png',
                                alignment: Alignment.center,
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
                              widget.recipeName,
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
                                    visible: isFavorite,
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
        ),
      );
    });
  }
}
