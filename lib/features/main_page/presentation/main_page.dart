import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/random_recipe/random_recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/random_recipe/random_recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/random_recipe/random_recipe_state.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';
import 'package:recipes/features/main_page/presentation/widgets/recipe_card_random.dart';
import '../../common/widgets/menu_icon_widget.dart';
import '../../common/widgets/nav_bar_text_favourites.dart';

class MainPage extends StatelessWidget {
  final AuthenticationBloc authenticationBloc = AuthenticationBloc(authenticationService: AuthenticationService());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RandomRecipeBloc(RecipeService(), authenticationBloc)..add(FetchRandomRecipe())),
        BlocProvider.value(value: authenticationBloc),
      ],
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
                child: Stack(
                  children: [
                    BlocBuilder<RandomRecipeBloc, RandomRecipeState>(
                      builder: (context, recipeState) {
                        if (recipeState is RecipeLoading) {
                          return Center(child: CircularProgressIndicator(color: Color(0xFFFF6E41)));
                        } else if (recipeState is RecipeLoaded) {
                          final recipe = recipeState.recipe;
                          return RecipeCardRandom(
                              image: recipe.image,
                              recipeName: recipe.title,
                              isFavorite: recipe.isFavouriteRecipe,
                              id: recipe.id
                          );
                        } else if (recipeState is RecipeError) {
                          return Center(child: Text('Error: ${recipeState.message}'));
                        } else {
                          return Center(child: Text('No data'));
                        }
                      },
                    ),
                    UnauthenticatedWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}