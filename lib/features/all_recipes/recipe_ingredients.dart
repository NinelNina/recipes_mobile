import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_state.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/nav_bar_title_clouse.dart';
import 'package:recipes/features/common/recipe_card/recipe_card_Ingredients.dart';

class RecipeIngredients extends StatelessWidget {
  final int recipeId;

  RecipeIngredients({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return BlocProvider(
      create: (context) => RecipeBloc(RecipeService())..add(FetchRecipe(recipeId)),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is RecipeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RecipeLoaded) {
                    final recipe = state.recipe;
                    return Expanded(
                      child: Column(
                        children: [
                          NavBarTitleCl(
                            title: recipe.title,
                            navWidget: BackIconWidget(width: width),
                            width: width,
                            height: height,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return RecipeCardIngredients(
                                  id: 0,
                                  image: recipe.image,
                                  title: recipe.title,
                                  readyInMinutes: '${recipe.readyInMinutes} min',
                                  isFavouriteRecipe: recipe.isFavouriteRecipe,
                                  extendedIngredients: recipe.extendedIngredients,
                                  steps: recipe.steps,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is RecipeError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Center(child: Text('No data'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
