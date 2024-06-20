import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_state.dart';

class UnauthenticatedWidget extends StatelessWidget {
  const UnauthenticatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, authState) {
        if (authState is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
        }
      },
      child: Container(),
    );
  }
}
