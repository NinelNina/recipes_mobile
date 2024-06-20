import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/register_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final Register register;

  const RegisterButtonPressed({required this.register});

  @override
  List<Object> get props => [register];
}