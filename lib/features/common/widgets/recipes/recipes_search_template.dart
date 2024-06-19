import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
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
    required this.height, required this.query,
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

  Future<void> _fetchPage(int pageKey) async {
    context.read<RecipeSearchBloc>().add(
      FetchRecipes(
          isUserRecipe: widget.isUserRecipe,
          type: widget.type,
          diet: widget.diet,
          page: pageKey,
          number: _pageSize,
          query: widget.query
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
