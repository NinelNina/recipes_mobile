import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_event.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_state.dart';
import 'package:recipes/features/all_recipes/full_recipe_screen.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/top_row/top_bar.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/core/domain/services/favorite_service.dart';

class FavouriteRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Bar(
              title: 'Favourites',
              showSearch: false,
              showIconFavorite: false,
              navWidget: MenuIconWidget(width: width),
              width: width,
              height: height,
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => FavoriteBloc(favoriteService: FavoriteService())..add(GetFavoriteRecipes()),
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoriteLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is FavoriteLoaded) {
                      final recipes = state.recipes;
                      return ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final recipe = recipes[index];
                          return RecipeCard(
                              image: recipe.image,
                              recipeName: recipe.title,
                              isFavorite: true,
                              id: recipe.id,
                          );
                        },
                      );
                    } else if (state is FavoriteError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return Center(child: Text('No data'));
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
