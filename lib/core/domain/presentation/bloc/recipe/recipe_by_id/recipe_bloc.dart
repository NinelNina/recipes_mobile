import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_state.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeService recipeService;
  final AuthenticationBloc authenticationBloc;

  RecipeBloc(this.recipeService, this.authenticationBloc) : super(RecipeInitial()) {
    on<FetchRecipe>(_onFetchRecipe);
  }

  void _onFetchRecipe(FetchRecipe event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      final recipe = await recipeService.fetchRecipe(event.id, event.isUserRecipe);
      emit(RecipeLoaded(recipe));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(RecipeError('Unauthorized. Please log in again.'));
        }
      } else {
        emit(RecipeError(e.toString()));
      }
    }
  }
}