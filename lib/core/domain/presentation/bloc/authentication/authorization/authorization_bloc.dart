import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/user_service.dart';
import 'authorization_event.dart';
import 'authorization_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  final UserService tokenService = UserService();

  AuthenticationBloc({required this.authenticationService}) : super(AuthenticationInitial()) {
    on<AuthenticationButtonPressed>(onAuthenticationButtonPressed);
  }

  void onAuthenticationButtonPressed(AuthenticationButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final response = await authenticationService.authenticate(event.request);
      await tokenService.saveToken(response.token);
      await tokenService.saveUsername(response.email);
      await tokenService.saveRole(response.role.toLowerCase());
      emit(AuthenticationSuccess(token: response.token));
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 403) {
        emit(AuthenticationFailure(error: 'Invalid email or password'));
      } else {
        emit(AuthenticationFailure(error: 'An unexpected error occurred'));
      }
    }
  }
}
