import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'recipe_search_event.dart';
import 'recipe_search_state.dart';

const _postLimit = 20;

class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  final RecipeService recipeService;
  final AuthenticationBloc authenticationBloc;

  RecipeSearchBloc({
    required this.authenticationBloc,
    required this.recipeService,
  }) : super(const RecipeSearchState()) {
    on<FetchRecipes>(_onFetchRecipes);
  }

  Future<void> _onFetchRecipes(FetchRecipes event, Emitter<RecipeSearchState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == RecipeSearchStatus.initial) {
        final recipes = await recipeService.fetchComplexSearch(
          event.query,
          event.isUserRecipe,
          event.type,
          event.diet,
          event.page,
          number: event.number,
        );
        return emit(
          state.copyWith(
            status: RecipeSearchStatus.success,
            recipes: recipes,
            hasReachedMax: false,
          ),
        );
      }
      emit(state.copyWith(status: RecipeSearchStatus.loading));
      final recipes = await recipeService.fetchComplexSearch(
        event.query,
        event.isUserRecipe,
        event.type,
        event.diet,
        state.recipes.length ~/ _postLimit + 1,
        number: event.number,
      );
      recipes.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: RecipeSearchStatus.success,
          recipes: List.of(state.recipes)..addAll(recipes),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(state.copyWith(status: RecipeSearchStatus.failure));
        }
      } else {
        emit(state.copyWith(status: RecipeSearchStatus.failure));
      }
    }
  }
}
