import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/authentication_request.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationButtonPressed extends AuthenticationEvent {
  final AuthenticationRequest request;

  const AuthenticationButtonPressed({required this.request});

  @override
  List<Object> get props => [request];
}

class LoggedOut extends AuthenticationEvent {}
