import 'package:flutter/material.dart';
import 'package:recipes/core/domain/services/user_service.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserService _tokenService = UserService();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _tokenService.getToken();
    if (token != null) {
      userRole = (await _tokenService.getRole())!;
      print(userRole);
      if (userRole == 'user') {
        Navigator.pushReplacementNamed(context, '/home');
      }
      else if (userRole == 'administrator') {
        Navigator.pushReplacementNamed(context, '/admin_profile');
      }
      else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFFFF6E41)),
      ),
    );
  }
}
