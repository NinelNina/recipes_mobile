import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'user_recipe_event.dart';
import 'user_recipe_state.dart';

class UserRecipeBloc extends Bloc<UserRecipeEvent, UserRecipeState> {
  final UserRecipeService userRecipeService;
  final AuthenticationBloc authenticationBloc;

  UserRecipeBloc(this.userRecipeService, this.authenticationBloc) : super(UserRecipeInitial()) {
    on<FetchUserRecipes>(_onFetchUserRecipes);
    on<CreateUserRecipe>(_onCreateUserRecipe);
  }

  Future<void> _onFetchUserRecipes(
      FetchUserRecipes event, Emitter<UserRecipeState> emit) async {
    emit(UserRecipeLoading());
    try {
      final recipes = await userRecipeService.getUserRecipes(page: event.page, number: event.number);
      if (recipes.isEmpty && event.page == 0) {
        emit(UserRecipeEmpty());
      } else {
        emit(UserRecipeLoaded(recipes, event.page));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(UserRecipeError('Unauthorized. Please log in again.'));
        }
      } else {
        emit(UserRecipeError('Failed to load user recipes: ${e.toString()}'));
      }
    }
  }

  Future<void> _onCreateUserRecipe(
      CreateUserRecipe event, Emitter<UserRecipeState> emit) async {
    emit(UserRecipeLoading());
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
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(UserRecipeError('Unauthorized. Please log in again.'));
        }
      } else {
        emit(UserRecipeError('Failed to create user recipe: ${e.toString()}'));
      }
    }
  }
}
