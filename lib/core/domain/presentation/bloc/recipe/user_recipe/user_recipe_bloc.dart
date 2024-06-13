import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'user_recipe_event.dart';
import 'user_recipe_state.dart';

class UserRecipeBloc extends Bloc<UserRecipeEvent, UserRecipeState> {
  final UserRecipeService userRecipeService;

  UserRecipeBloc(this.userRecipeService) : super(UserRecipeInitial()) {
    on<FetchUserRecipes>(_onFetchUserRecipes);
    on<CreateUserRecipe>(_onCreateUserRecipe);
  }

  Future<void> _onFetchUserRecipes(
      FetchUserRecipes event, Emitter<UserRecipeState> emit) async {
    emit(UserRecipeLoading());
    try {
      final recipes = await userRecipeService.getUserRecipes();
      emit(UserRecipeLoaded(recipes));
    } catch (e) {
      emit(UserRecipeError('Failed to load user recipes: ${e.toString()}'));
    }
  }

  Future<void> _onCreateUserRecipe(
      CreateUserRecipe event, Emitter<UserRecipeState> emit) async {
    try {
      await userRecipeService.createUserRecipe(
        title: event.title,
        image: event.image,
        imageExtension: event.imageExtension,
        description: event.description,
        category: event.category,
        readyInMinutes: event.readyInMinutes,
        extendedIngredients: event.extendedIngredients,
        steps: event.steps,
        isPublish: event.isPublish,
      );
      emit(UserRecipeCreated());
    } catch (e) {
      emit(UserRecipeError('Failed to create user recipe: ${e.toString()}'));
    }
  }
}
