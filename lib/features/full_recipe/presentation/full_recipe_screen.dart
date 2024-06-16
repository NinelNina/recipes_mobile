import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_state.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/recipe_card/full_recipe_card.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/common/widgets/nav_bar_title_clouse.dart';

class FullRecipe extends StatelessWidget {
  final int recipeId;
  final bool isUserRecipe;

  FullRecipe({required this.recipeId, required this.isUserRecipe});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return BlocProvider(
      create: (context) =>
          RecipeBloc(RecipeService())..add(FetchRecipe(recipeId, isUserRecipe)),
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
                            title: recipe.title.toUpperCase(),
                            navWidget: BackIconWidget(width: width),
                            width: width,
                            height: height,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return FullRecipeCard(
                                  id: recipe.id,
                                  image: recipe.image,
                                  title: recipe.title,
                                  readyInMinutes:
                                      '${recipe.readyInMinutes} min',
                                  isFavouriteRecipe: recipe.isFavouriteRecipe,
                                  extendedIngredients:
                                      recipe.extendedIngredients,
                                  steps: recipe.steps,
                                  isUserRecipe: recipe.isUserRecipe,
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
