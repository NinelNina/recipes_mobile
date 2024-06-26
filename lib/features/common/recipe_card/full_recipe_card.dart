import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/features/common/recipe_card/favourite_button.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

import '../widgets/custom_toggle_button.dart';

class FullRecipeCard extends StatefulWidget {
  final int id;
  final String? image;
  final String title;
  final String? type;
  final String? readyInMinutes;
  final bool isFavouriteRecipe;
  final bool isUserRecipe;
  final List<Ingredient>? extendedIngredients;
  final List<String>? steps;


  const FullRecipeCard({
    required this.id,
    required this.image,
    required this.title,
    required this.readyInMinutes,
    required this.isFavouriteRecipe,
    required this.extendedIngredients,
    required this.steps,
    required this.isUserRecipe,
    required this.type,
  });

  @override
  _FullRecipeCardState createState() => _FullRecipeCardState();
}

class _FullRecipeCardState extends State<FullRecipeCard> {
  int selectedIndex = 0;
  int portions = 1;

  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(authenticationService: AuthenticationService());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authenticationBloc)
      ],
      child: Column(
        children: [
          UnauthenticatedWidget(),
          SizedBox(height: height * 0.026),
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: height * 0.46,
                ),
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

                              offset: Offset(0, 3),

                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: Color(0xFFFF6E41),
                            width: 1,
                          ),
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
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
                    ),
                    Positioned(
                      top: height * 0.395,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Container(child: Column(
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
                                Text(
                                  widget.readyInMinutes!,
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
                        ),
                        constraints: BoxConstraints(
                          minHeight: height * 0.06,
                        ),
                      ),
                    ),
                    userRole == 'administrator'
                        ? SizedBox()
                        : Positioned(
                            top: height * 0.341,
                            right: width * 0.078,
                            child: FavoritesButton(
                              recipeId: widget.id,
                              isUserRecipe: widget.isUserRecipe,
                              isFavorite: widget.isFavouriteRecipe,
                            ),
                          ),
                    widget.type == null
                    ? SizedBox()
                    : Positioned(
                      top: height * 0.01,
                      left: width * 0.044,
                      child: Container(
                        width: width * 0.21,
                        height: height * 0.047,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xFFFF6E41),
                            width: 1,
                          ),
                        ),

                        child: Center(
                              child: Text(
                                widget.type.toString().toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),

                        ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.008),
          CustomToggleButton(
              extendedIngredients: widget.extendedIngredients!,
              steps: widget.steps),
        ],
      ),
    );
  }
}
