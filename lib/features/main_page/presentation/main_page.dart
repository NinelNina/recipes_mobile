import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/random_recipe/random_recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/random_recipe/random_recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/random_recipe/random_recipe_state.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/main_page/presentation/widgets/recipe_card_random.dart';

import '../../common/widgets/menu_icon_widget.dart';
import '../../common/widgets/nav_bar_text_favourites.dart';

class MainPage extends StatelessWidget {
  final List<String> recipes = [
    'Recipe 1',
    'Recipe 2',
    'Recipe 3',
    'Recipe 4',
    'Recipe 5',
  ];

  final List<String> images = [
    'assets/images/imageRecipe.jpeg',
  ];

  final List<bool> isFavorite = [
    true,
    false,
    false,
    false,
    false,
  ];

  final List<String> cookingTime = [
    '30 min',
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return BlocProvider(
      create: (context) => RandomRecipeBloc(RecipeService())..add(FetchRandomRecipe()),
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              NavBarWithTextAndFavorites(
                title: 'Main page',
                navWidget: MenuIconWidget(width: width),
                width: width,
                height: height,
              ),
              SizedBox(height: 35),
              Expanded(
                child: BlocBuilder<RandomRecipeBloc, RandomRecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RecipeLoaded) {
                      final recipe = state.recipe;
                      return RecipeCardRandom(
                          image: recipe.image,
                          recipeName: recipe.title,
                          isFavorite: recipe.isFavouriteRecipe,
                          id: recipe.id
                      );
                    } else if (state is RecipeError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return Center(child: Text('No data'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
