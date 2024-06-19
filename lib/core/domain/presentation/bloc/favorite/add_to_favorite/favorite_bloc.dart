import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/favorite_service.dart';

import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteService favoriteService;
  final AuthenticationBloc authenticationBloc;

  FavoriteBloc(this.authenticationBloc, {required this.favoriteService})
      : super(FavoriteInitial()) {
    on<AddRecipeToFavorite>(_onAddRecipeToFavorite);
    on<DeleteRecipeFromFavorite>(_onDeleteRecipeFromFavorite);
    on<GetFavoriteRecipes>(_onGetFavoriteRecipes);
  }

  Future<void> _onAddRecipeToFavorite(
      AddRecipeToFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      await favoriteService.addRecipeToFavorite(
          event.recipeId, event.isUserRecipe);
      emit(FavoriteAdded(recipeId: event.recipeId, isFavorite: true));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(FavoriteError(message: 'Unauthorized. Please log in again.'));
        }
      } else {
        emit(FavoriteError(message: e.toString()));
      }
    }
  }

  Future<void> _onDeleteRecipeFromFavorite(
      DeleteRecipeFromFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      await favoriteService.deleteRecipeFromFavorite(
          event.recipeId, event.isUserRecipe);
      emit(FavoriteAdded(recipeId: event.recipeId, isFavorite: false));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(FavoriteError(message: 'Unauthorized. Please log in again.'));
        }
      } else {
        emit(FavoriteError(message: e.toString()));
      }
    }
  }

  Future<void> _onGetFavoriteRecipes(
      GetFavoriteRecipes event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final recipes = await favoriteService.getFavoriteRecipe(event.page,
          number: event.number);
      emit(FavoriteLoaded(recipes: recipes));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(FavoriteError(message: 'Unauthorized. Please log in again.'));
        }
      } else {
        emit(FavoriteError(message: e.toString()));
      }
    }
  }
}
