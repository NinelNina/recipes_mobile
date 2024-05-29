import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/services/favorite_service.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteService favoriteService;

  FavoriteBloc({required this.favoriteService}) : super(FavoriteInitial()) {
    on<AddRecipeToFavorite>(_onAddRecipeToFavorite);
    on<DeleteRecipeFromFavorite>(_onDeleteRecipeFromFavorite);
    on<GetFavoriteRecipes>(_onGetFavoriteRecipes);
  }

  Future<void> _onAddRecipeToFavorite(AddRecipeToFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      await favoriteService.addRecipeToFavorite(event.recipeId, event.isUserRecipe);
      emit(FavoriteInitial());
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  Future<void> _onDeleteRecipeFromFavorite(DeleteRecipeFromFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      await favoriteService.deleteRecipeFromFavorite(event.recipeId, event.isUserRecipe);
      emit(FavoriteInitial());
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  Future<void> _onGetFavoriteRecipes(GetFavoriteRecipes event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final recipes = await favoriteService.getFavoriteRecipe(event.page, number: event.number);
      emit(FavoriteLoaded(recipes: recipes));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }
}
