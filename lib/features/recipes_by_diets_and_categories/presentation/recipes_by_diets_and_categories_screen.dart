import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_bloc.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/recipes/recipes_search_template.dart';
import 'package:recipes/features/common/widgets/recipes/recipes_template.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/common/widgets/nav_bar_with_favourites.dart';

class RecipesByDietsAndCategoriesScreen extends StatefulWidget {
  final String? diet;
  final String? type;

  const RecipesByDietsAndCategoriesScreen({super.key, this.diet, this.type});

  @override
  State<RecipesByDietsAndCategoriesScreen> createState() =>
      _RecipesByDietsAndCategoriesScreenState();
}

class _RecipesByDietsAndCategoriesScreenState
    extends State<RecipesByDietsAndCategoriesScreen> {
  bool isSearchActive = false;

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

    String title = widget.diet ?? widget.type!;

    return Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: BlocProvider(
            create: (context) =>
                RecipeSearchBloc(recipeService: RecipeService()),
            child: Column(
              children: [
                NavBarWithFavorites(
                  title: title,
                  navWidget: MenuIconWidget(width: width),
                  width: width,
                  height: height,
                  isUserRecipe: false,
                  diet: widget.diet,
                  type: widget.type,
                  onSearchPressed: _handleSearchPressed,
                ),
                isSearchActive
                    ? RecipesSearchTemplate(width: width, height: height)
                    : RecipesTemplate(
                        isUserRecipe: false,
                        width: width,
                        height: height,
                        diet: widget.diet,
                        type: widget.type)
              ],
            ),
          ),
        ));
  }
}