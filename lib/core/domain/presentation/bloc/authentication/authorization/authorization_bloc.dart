import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'authorization_event.dart';
import 'authorization_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;

  AuthenticationBloc({required this.authenticationService}) : super(AuthenticationInitial());

  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationButtonPressed) {
      yield AuthenticationLoading();
      try {
        final response = await authenticationService.authenticate(event.request);
        yield AuthenticationSuccess(token: response.token);
      } catch (error) {
        yield AuthenticationFailure(error: error.toString());
      }
    }
  }
}
