import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';

import 'random_recipe_event.dart';
import 'random_recipe_state.dart';

class RandomRecipeBloc extends Bloc<RandomRecipeEvent, RandomRecipeState> {
  final RecipeService recipeService;
  final AuthenticationBloc authenticationBloc;

  RandomRecipeBloc(this.recipeService, this.authenticationBloc) : super(RecipeInitial()) {
    on<FetchRandomRecipe>(_onFetchRandomRecipePreview);
  }

  void _onFetchRandomRecipePreview(FetchRandomRecipe event, Emitter<RandomRecipeState> emit) async {
      emit(RecipeLoading());
      try {
        final recipe = await recipeService.fetchRandomRecipePreview();
        emit(RecipeLoaded(recipe));
      } catch (error) {
        if (error is DioException) {
          if (error.response?.statusCode == 403) {
            emit(RecipeError('Sorry, recipes are not available right now :('));
          }
          else if (error.response?.statusCode == 401) {
            authenticationBloc.add(LoggedOut());
            emit(RecipeError('Unauthorized. Please log in again.'));
          }
        }
        else {
          emit(RecipeError('An unexpected error occurred'));
        }
      }
  }
}
