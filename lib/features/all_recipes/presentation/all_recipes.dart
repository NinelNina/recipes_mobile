import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_event.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/recipes/recipes_template.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/common/widgets/nav_bar_with_favourites.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';

class AllRecipes extends StatefulWidget {
  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  bool isSearchActive = false;
  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(authenticationService: AuthenticationService());

  void _handleSearchPressed() {
    setState(() {
      isSearchActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    int page = 0;
    int number = 10;

    return Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => RecipeSearchBloc(
                      recipeService: RecipeService(),
                      authenticationBloc: authenticationBloc)
                    ..add(FetchRecipes(
                        isUserRecipe: false,
                        type: null,
                        diet: null,
                        page: page,
                        number: number,
                        query: null))),
              BlocProvider.value(value: authenticationBloc)
            ],
            child: Column(
              children: [
                NavBarWithFavorites(
                  title: 'Recipes',
                  navWidget: MenuIconWidget(width: width),
                  width: width,
                  height: height,
                  isUserRecipe: false,
                  onSearchPressed: _handleSearchPressed,
                ),
                UnauthenticatedWidget(),
                Expanded(
                  child:RecipesTemplate(
                      isUserRecipe: false, width: width, height: height),
/*
                  child: isSearchActive
                      ? Container() //RecipesSearchTemplate(width: width, height: height)
                      : RecipesTemplate(
                          isUserRecipe: false, width: width, height: height),
*/
                )
              ],
            ),
          ),
        ));
  }
}
