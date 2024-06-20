import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_event.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_state.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';

class RecipesToCheckTemplate extends StatefulWidget {

  const RecipesToCheckTemplate({
    super.key
  });

  @override
  _RecipesToCheckTemplateState createState() => _RecipesToCheckTemplateState();
}

class _RecipesToCheckTemplateState extends State<RecipesToCheckTemplate> {
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
    context.read<AdminBloc>().add(
      FetchRecipesToCheck(
          page: pageKey,
          number: _pageSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is RecipesLoaded) {
              final isLastPage = state.recipes.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(state.recipes);
              } else {
                final nextPageKey = state.page + 1;
                _pagingController.appendPage(state.recipes, nextPageKey);
              }
            } else if (state is AdminError) {
              _pagingController.error = state.message;
            } else if (state is RecipeEmpty) {
              _pagingController.appendLastPage([]);
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
