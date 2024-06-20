import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_state.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_state.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';

class MyRecipesTemplate extends StatefulWidget {

  const MyRecipesTemplate({
    super.key
  });

  @override
  _MyRecipesTemplateState createState() => _MyRecipesTemplateState();
}

class _MyRecipesTemplateState extends State<MyRecipesTemplate> {
  static const _pageSize = 10;
  final PagingController<int, RecipePreview> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    context.read<UserRecipeBloc>().add(
      FetchUserRecipes(
          page: pageKey,
          number: _pageSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserRecipeBloc, UserRecipeState>(
          listener: (context, state) {
            if (state is UserRecipeLoaded) {
              final isLastPage = state.recipes.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(state.recipes);
              } else {
                final nextPageKey = state.page + 1;
                _pagingController.appendPage(state.recipes, nextPageKey);
              }
            } else if (state is UserRecipeError) {
              _pagingController.error = state.message;
            } else if (state is UserRecipeEmpty) {
              _pagingController.appendLastPage([]);
            }
          },
        ),
        BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteAdded) {
              final recipeIndex = _pagingController.itemList?.indexWhere(
                      (recipe) => recipe.id == state.recipeId);

              if (recipeIndex != null && recipeIndex != -1) {
                final updatedRecipe = _pagingController.itemList![recipeIndex]
                    .copyWith(isFavouriteRecipe: state.isFavorite);

                final updatedList = List<RecipePreview>.from(
                    _pagingController.itemList!);
                updatedList[recipeIndex] = updatedRecipe;

                _pagingController.itemList = updatedList;
              }
            }
          },
        ),
      ],
      child: PagedListView<int, RecipePreview>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<RecipePreview>(
          itemBuilder: (context, recipe, index) => RecipeCard(
            image: recipe.image,
            recipeName: recipe.title,
            isFavorite: recipe.isFavouriteRecipe,
            id: recipe.id,
            isUserRecipe: recipe.isUserRecipe,
          ),
          noItemsFoundIndicatorBuilder: (context) => Column(
            children: [
              SizedBox(height: 10),
              Text('There\'s nothing here :('),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
