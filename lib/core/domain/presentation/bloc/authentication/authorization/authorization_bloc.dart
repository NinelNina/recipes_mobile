import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'authorization_event.dart';
import 'authorization_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;

  AuthenticationBloc({required this.authenticationService}) : super(AuthenticationInitial()) {
    on<AuthenticationButtonPressed>(onAuthenticationButtonPressed);
  }

  void onAuthenticationButtonPressed(AuthenticationButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final response = await authenticationService.authenticate(event.request);
      emit(AuthenticationSuccess(token: response.token));
    } catch (error) {
      emit(AuthenticationFailure(error: error.toString()));
    }
  }
}
