import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_event.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_state.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/services/admin_service.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminService adminService;
  final AuthenticationBloc authenticationBloc;

  AdminBloc({required this.authenticationBloc, required this.adminService}) : super(AdminInitial()) {
    on<LoadStatistic>(_onLoadStatistic);
    on<FetchRecipesToCheck>(_onFetchRecipesToCheck);
    on<CheckRecipe>(_onCheckRecipe);
  }

  void _onLoadStatistic(LoadStatistic event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final statistic = await adminService.getStatistic();
      emit(StatisticLoaded(statistic: statistic));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(AdminError(message: 'Unauthorized. Please log in again.'));
        }
      } else {
        emit(AdminError(message: e.toString()));
      }
    }
  }

  void _onFetchRecipesToCheck(FetchRecipesToCheck event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final recipes = await adminService.fetchRecipesToCheck(event.page, number: event.number);
      emit(RecipesLoaded(recipes: recipes));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(AdminError(message: 'Unauthorized. Please log in again.'));
        }
      } else {
        emit(AdminError(message: e.toString()));
      }
    }
  }

  void _onCheckRecipe(CheckRecipe event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminService.checkRecipe(event.recipeId, event.isApproved);
      emit(event.isApproved ? RecipeApproved() : RecipeRejected());
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          authenticationBloc.add(LoggedOut());
          emit(AdminError(message: 'Unauthorized. Please log in again.'));
        }
      } else {
        emit(AdminError(message: e.toString()));
      }
    }
  }
}