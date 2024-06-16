import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';

import 'recipe_search_event.dart';
import 'recipe_search_state.dart';

class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  final RecipeService recipeService;

  RecipeSearchBloc({required this.recipeService}) : super(RecipeSearchInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
  }

  Future<void> _onFetchRecipes(FetchRecipes event, Emitter<RecipeSearchState> emit) async {
    emit(RecipeSearchLoading());
    try {
      final recipes = await recipeService.fetchComplexSearch(
        event.query,
        event.isUserRecipe,
        event.type,
        event.diet,
        event.page,
        number: event.number,
      );
      emit(RecipeSearchLoaded(recipes));
    } catch (e) {
      emit(RecipeSearchError(e.toString()));
    }
  }
}