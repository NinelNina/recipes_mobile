import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_state.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/all_recipes/full_recipe_screen.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/nav_bar_with_favourites.dart';

class AllRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    //TODO: бесконечная лента
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            NavBarWithFavorites(
              title: 'Recipes',
              navWidget: MenuIconWidget(width: width),
              width: width,
              height: height,
            ),
            BlocProvider(
              create: (context) => RecipeSearchBloc(recipeService: RecipeService())
                ..add(FetchRecipes(isUserRecipe: false)),
              child: Expanded(
                child: BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
                  builder: (context, state) {
                    if (state is RecipeSearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RecipeSearchLoaded) {
                      return ListView.builder(
                        itemCount: state.recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final recipe = state.recipes[index];
                          return  RecipeCard(
                              image: recipe.image,
                              recipeName: recipe.title,
                              isFavorite: recipe.isFavouriteRecipe,
                              id: recipe.id,
                              isUserRecipe: recipe.isUserRecipe,
                          );
                        },
                      );
                    } else if (state is RecipeSearchError) {
                      return Center(child: Text('Failed to load recipes: ${state.message}'));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
