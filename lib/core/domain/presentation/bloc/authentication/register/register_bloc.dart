import 'package:bloc/bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/user_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationService authenticationService;
  final UserService userService = UserService();

  RegisterBloc({required this.authenticationService}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  void _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await authenticationService.register(event.register);
      await userService.saveToken(response.token);
      await userService.saveUsername(response.email);
      await userService.saveRole(response.role.toLowerCase());
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}