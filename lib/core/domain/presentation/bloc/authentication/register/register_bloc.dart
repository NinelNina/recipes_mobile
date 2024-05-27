import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationService authenticationService;
  RegisterBloc({required this.authenticationService}) : super(RegisterInitial());

  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        await authenticationService.register(event.register);
        yield RegisterSuccess();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}
