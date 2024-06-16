import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';

import 'random_recipe_event.dart';
import 'random_recipe_state.dart';

class RandomRecipeBloc extends Bloc<RandomRecipeEvent, RandomRecipeState> {
  final RecipeService recipeService;

  RandomRecipeBloc(this.recipeService) : super(RecipeInitial()) {
    on<FetchRandomRecipe>(_onFetchRandomRecipePreview);
  }

  void _onFetchRandomRecipePreview(FetchRandomRecipe event, Emitter<RandomRecipeState> emit) async {
      emit(RecipeLoading());
      try {
        final recipe = await recipeService.fetchRandomRecipePreview();
        emit(RecipeLoaded(recipe));
      } catch (error) {
        if (error is DioException && error.response?.statusCode == 403) {
          emit(RecipeError('Sorry, recipes are not available right now :('));
        } else {
          emit(RecipeError('An unexpected error occurred'));
        }
      }
  }
}
