import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_state.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_state.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';

class RecipesSearchTemplate extends StatefulWidget {
  final double width;
  final double height;
  final bool isUserRecipe;
  final String? type;
  final String? diet;
  final String query;

  const RecipesSearchTemplate({
    super.key,
    required this.isUserRecipe,
    this.type,
    this.diet,
    required this.width,
    required this.height,
    required this.query,
  });

  @override
  _RecipesSearchTemplateState createState() => _RecipesSearchTemplateState();
}

class _RecipesSearchTemplateState extends State<RecipesSearchTemplate> {
  static const _pageSize = 10;
  final PagingController<int, RecipePreview> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void didUpdateWidget(covariant RecipesSearchTemplate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query ||
        oldWidget.type != widget.type ||
        oldWidget.diet != widget.diet ||
        oldWidget.isUserRecipe != widget.isUserRecipe) {
      _pagingController.refresh();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    context.read<RecipeSearchBloc>().add(
      FetchRecipes(
        isUserRecipe: widget.isUserRecipe,
        type: widget.type,
        diet: widget.diet,
        page: pageKey,
        number: _pageSize,
        query: widget.query,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocListener(
      listeners: [
        BlocListener<RecipeSearchBloc, RecipeSearchState>(
          listener: (context, state) {
            if (state is RecipeSearchLoaded) {
              final isLastPage = state.recipes.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(state.recipes);
              } else {
                final nextPageKey = state.page + 1;
                _pagingController.appendPage(state.recipes, nextPageKey);
              }
            } else if (state is RecipeSearchError) {
              _pagingController.error = state.message;
            } else if (state is RecipeSearchEmpty) {
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
          noItemsFoundIndicatorBuilder: (context) => Column(children: [
            SizedBox(height: 10),
                  Text('There\'s nothing here :('.toUpperCase(),
          style: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xFF000000),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          ),
          ),
          ]
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
