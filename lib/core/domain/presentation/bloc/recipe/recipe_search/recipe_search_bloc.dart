import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'recipe_search_event.dart';
import 'recipe_search_state.dart';

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
    try {
      final recipes = await recipeService.fetchComplexSearch(
        event.query,
        event.isUserRecipe,
        event.type,
        event.diet,
        event.page,
        number: event.number,
      );

      if (recipes.isEmpty && event.page == 1) {
        emit(RecipeSearchEmpty());
      } else {
        emit(RecipeSearchLoaded(recipes, event.page));
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
