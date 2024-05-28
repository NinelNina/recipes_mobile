import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/models/diet_model.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/models/meal_type_model.dart';
import 'package:recipes/core/domain/services/recipe_info_service.dart';
import 'recipe_info_event.dart';
import 'recipe_info_state.dart';

class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  final RecipeInfoService recipeInfoService;

  RecipeInfoBloc({required this.recipeInfoService}) : super(RecipeInfoInitial()) {
    on<FetchIngredients>(_onFetchIngredients);
    on<FetchDiets>(_onFetchDiets);
    on<FetchMealTypes>(_onFetchMealTypes);
  }

  Future<void> _onFetchIngredients(FetchIngredients event, Emitter<RecipeInfoState> emit) async {
    emit(RecipeInfoLoading());
    try {
      final ingredients = await recipeInfoService.getIngredients();
      emit(RecipeInfoLoaded<Ingredient>(ingredients));
    } catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }

  Future<void> _onFetchDiets(FetchDiets event, Emitter<RecipeInfoState> emit) async {
    emit(RecipeInfoLoading());
    try {
      final diets = await recipeInfoService.getDiets();
      emit(RecipeInfoLoaded<Diet>(diets));
    } catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }

  Future<void> _onFetchMealTypes(FetchMealTypes event, Emitter<RecipeInfoState> emit) async {
    emit(RecipeInfoLoading());
    try {
      final mealTypes = await recipeInfoService.getMealTypes();
      emit(RecipeInfoLoaded<MealType>(mealTypes));
    } catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }
}
