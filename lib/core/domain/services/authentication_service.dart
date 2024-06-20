import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/authentication_request.dart';
import 'package:recipes/core/domain/models/authentication_response.dart';
import '../models/register_model.dart';
import 'package:dio/dio.dart';

class AuthenticationService {
  final Dio dio = Dio();

  Future<AuthenticationResponse> register(Register register) async {
    try {
      final response = await dio.post(
        '$apiRoot/v1/auth/register',
        data: {
          'email': register.email,
          'password': register.password,
        },
      );
      if (response.statusCode == 200) {
        return AuthenticationResponse.fromJson(response.data);
      } else {
        throw Exception('Failed registering user');
      }
    } on DioException catch (e) {
      print('Error registering user: $e');
      throw e;
    }
  }

  Future<AuthenticationResponse> authenticate(
      AuthenticationRequest request) async {
    try {
      final response = await dio.post(
        '$apiRoot/v1/auth/authenticate',
        data: {
          'email': request.email,
          'password': request.password,
        },
      );
      if (response.statusCode == 200) {
        return AuthenticationResponse.fromJson(response.data);
      } else {
        throw Exception('Failed user authentication');
      }
    } on DioException catch (e) {
      print('Error authenticating user: $e');
      throw e;
    }
  }
}
