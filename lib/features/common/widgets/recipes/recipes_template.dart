import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_search/recipe_search_state.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/widgets/recipes/bottom_loader.dart';

class RecipesTemplate extends StatefulWidget {
  final double width;
  final double height;
  final bool isUserRecipe;
  final String? type;
  final String? diet;

  const RecipesTemplate(
      {super.key,
      required this.isUserRecipe,
      this.type,
      this.diet,
      required this.width,
      required this.height});

  @override
  State<RecipesTemplate> createState() => _RecipesTemplateState();
}

class _RecipesTemplateState extends State<RecipesTemplate> {
  final _scrollController = ScrollController();
  final number = 10;
  int recipesSize = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authenticationService: AuthenticationService());

    return BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
      builder: (context, state) {
        switch (state.status) {
          case RecipeSearchStatus.failure:
            return Center(child: Text('Failed to load recipes'));
          case RecipeSearchStatus.success:
            if (state.recipes.isEmpty) {
              return Column(children: [
                SizedBox(height: 10),
                Text('There\'s nothing here :('),
              ]);
            }
            return ListView.builder(
              itemCount: state.hasReachedMax
                  ? state.recipes.length
                  : state.recipes.length + 1,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                recipesSize = state.recipes.length;
                return index >= state.recipes.length
                    ? const BottomLoader()
                    : RecipeCard(
                        image: state.recipes[index].image,
                        recipeName: state.recipes[index].title,
                        isFavorite: state.recipes[index].isFavouriteRecipe,
                        id: state.recipes[index].id,
                        isUserRecipe: state.recipes[index].isUserRecipe,
                      );
              },
            );
          case RecipeSearchStatus.initial:
          case RecipeSearchStatus.loading:
            return Center(
                child: CircularProgressIndicator(color: Color(0xFFFF6E41)));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      context.read<RecipeSearchBloc>().add(FetchRecipes(
          isUserRecipe: false,
          type: null,
          diet: null,
          page: recipesSize ~/ 10 + 1,
          number: number,
          query: null));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
