import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_event.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_state.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';

class FavoriteRecipesTemplate extends StatefulWidget {
  const FavoriteRecipesTemplate({super.key});

  @override
  _FavoriteRecipesTemplateState createState() =>
      _FavoriteRecipesTemplateState();
}

class _FavoriteRecipesTemplateState extends State<FavoriteRecipesTemplate> {
  static const _pageSize = 4;
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
    context.read<FavoriteBloc>().add(
          GetFavoriteRecipes(page: pageKey, number: _pageSize),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteLoaded) {
              final isLastPage = state.recipes.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(state.recipes);
              } else {
                final nextPageKey = state.page + 1;
                _pagingController.appendPage(state.recipes, nextPageKey);
              }
            } else if (state is FavoriteError) {
              _pagingController.error = state.message;
            } else if (state is FavoriteEmpty) {
              _pagingController.appendLastPage([]);
            }

            if (state is FavoriteAdded) {
              final recipeIndex = _pagingController.itemList
                  ?.indexWhere((recipe) => recipe.id == state.recipeId);

              if (recipeIndex != null && recipeIndex != -1) {
                final updatedList =
                List<RecipePreview>.from(_pagingController.itemList!);
                updatedList.removeAt(recipeIndex);

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
              Text(
                'There\'s nothing here :('.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          newPageProgressIndicatorBuilder: (context) => Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF6E41),
            ),
          ),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF6E41),
            ),
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
