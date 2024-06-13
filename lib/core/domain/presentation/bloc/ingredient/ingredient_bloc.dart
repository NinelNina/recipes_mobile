import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/ingredient/ingredient_event.dart';
import 'package:recipes/core/domain/presentation/bloc/ingredient/ingredient_state.dart';
import 'package:recipes/core/domain/services/ingredient_service.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientService ingredientService;

  IngredientBloc(this.ingredientService) : super(IngredientInitial()) {
    on<LoadIngredients>((event, emit) async {
      emit(IngredientLoading());
      try {
        final ingredients = await ingredientService.getIngredients();
        emit(IngredientLoaded(ingredients));
      } catch (e) {
        emit(IngredientError(e.toString()));
      }
    });
  }
}