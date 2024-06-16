import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/services/admin_service.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminService adminService;

  AdminBloc({required this.adminService}) : super(AdminInitial()) {
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
      emit(AdminError(message: e.toString()));
    }
  }

  void _onFetchRecipesToCheck(FetchRecipesToCheck event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final recipes = await adminService.fetchRecipesToCheck(event.page, number: event.number);
      emit(RecipesLoaded(recipes: recipes));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  void _onCheckRecipe(CheckRecipe event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await adminService.checkRecipe(event.recipeId, event.isApproved);
      emit(RecipeChecked());
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }
}
