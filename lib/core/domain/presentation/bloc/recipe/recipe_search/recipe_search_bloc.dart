import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'recipe_search_event.dart';
import 'recipe_search_state.dart';

const _postLimit = 10;

class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  final RecipeService recipeService;
  final AuthenticationBloc authenticationBloc;

  RecipeSearchBloc({
    required this.authenticationBloc,
    required this.recipeService,
  }) : super(RecipeSearchInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
  }

  Future<void> _onFetchRecipes(FetchRecipes event, Emitter<RecipeSearchState> emit) async {
    final currentState = state;
    if (currentState is RecipeSearchLoaded && currentState.hasReachedMax) return;

    try {
      if (currentState is RecipeSearchInitial || event.page == 0) {
        emit(RecipeSearchLoading());
      }

      final recipes = await recipeService.fetchComplexSearch(
        event.query,
        event.isUserRecipe,
        event.type,
        event.diet,
        event.page,
        number: event.number,
      );

      bool hasReachedMax = recipes.isEmpty || recipes.length < event.number!;

      if (currentState is RecipeSearchLoaded) {
        emit(recipes.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : RecipeSearchLoaded(
          recipes: currentState.recipes + recipes,
          hasReachedMax: hasReachedMax,
        ));
      } else {
        emit(RecipeSearchLoaded(
          recipes: recipes,
          hasReachedMax: hasReachedMax,
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(RecipeSearchError('Unauthorized. Please log in again.'));
        }
      } else {
        emit(RecipeSearchError(e.toString()));
      }
    }
  }
}
