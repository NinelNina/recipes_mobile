import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/authentication_request.dart';
import 'package:recipes/core/domain/models/authentication_response.dart';

import '../models/register_model.dart';
import 'package:dio/dio.dart';

class AuthenticationService {
  final Dio dio = Dio();

  Future<void> register(Register register) async {
    try {
      final response = await dio.post(
        '$apiRoot/v1/auth/register',
        data: {
          'email': register.email,
          'password': register.password,
        },
      );

      print('User registered: ${response.data}');
    } on DioException catch (e) {
      print('Error registering user: $e');
      throw e;
    }
  }

  Future<AuthenticationResponse> authenticate(AuthenticationRequest request) async {
    try {
      final response = await dio.post(
        'https://yourapi.com/authenticate',
        data: {
          'email': request.email,
          'password': request.password,
        },
      );
      return AuthenticationResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Error authenticating user: $e');
      throw e;
    }
  }
}