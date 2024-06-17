import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_state.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';

class RecipesSearchTemplate extends StatelessWidget {
  final double width;
  final double height;

  const RecipesSearchTemplate(
      {super.key,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    // int page = 0;
    // int number = 10;

    return Expanded(
        child: BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
          builder: (context, state) {
            if (state is RecipeSearchLoading) {
              return Center(
                  child: CircularProgressIndicator(color: Color(0xFFFF6E41)));
            } else if (state is RecipeSearchLoaded) {
              if (state.recipes.length == 0){
                return Column(children: [
                  SizedBox(height: 10),
                  Text('There\'s nothing here :('),
                ]);
              } else {
                return ListView.builder(
                  itemCount: state.recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final recipe = state.recipes[index];
                    return RecipeCard(
                      image: recipe.image,
                      recipeName: recipe.title,
                      isFavorite: recipe.isFavouriteRecipe,
                      id: recipe.id,
                      isUserRecipe: recipe.isUserRecipe,
                    );
                  },
                );
              }
            } else if (state is RecipeSearchError) {
              return Center(
                  child: Text('Failed to load recipes: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      //),
    );
  }
}
