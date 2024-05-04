import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/form_input_field.dart';
import 'package:recipes/features/common/widgets/nav_bar.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/nuv_bar_title_clouse.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';

import '../../all_resipes/all_recipes.dart';
import '../../dishes_categories/presentation/diets_categories_screen.dart';
import '../../dishes_categories/presentation/dishes_categories_screen.dart';
import '../../favorite_button.dart';
import '../../main_page/main_page.dart';
import '../../nav_bar_title.dart';

String userRole = '';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!value.contains('@')) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  void signIn() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Mock data for admin and user
      final adminEmail = 'admin@example.com';
      final adminPassword = 'password123';
      final userEmail = 'user@example.com';
      final userPassword = 'password456';

      if (email == adminEmail && password == adminPassword) {
        // Admin login
        userRole = 'admin';
        Navigator.pushNamed(context, '/admin_profile');
      } else if (email == userEmail && password == userPassword) {
        // User login
        if(isFromFavorites){
          userRole = 'user';
          Navigator.of(context).pop();
        }else {
          userRole = 'user';
          Navigator.pushNamed(context, '/user_profile');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        NavBarTitleCl(
            title: 'Sign In',
            navWidget: BackIconWidget(width: width),
            width: width,
            height: height),
        SizedBox(height: height * 0.05),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormInputField(
                        labelText: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        height: height,
                        obscureText: false,
                        validator: validateEmail),
                    SizedBox(height: height * 0.01),
                    FormInputField(
                        labelText: 'Password',
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        height: height,
                        obscureText: true,
                        validator: validatePassword),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              SubmitButton(
                text: 'Sign In',
                height: height * 0.06,
                width: width * 0.76,
                color: Color(0xFFFF6E41),
                textColor: Colors.white,
                onPressed: signIn,
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not registered yet?',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    child: Text(
                      ' Sign up',
                      style: TextStyle(
                        color: Color(0xFFFF6E41),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
            ])),
        Spacer(), // Add this to take up the remaining space
        Align(
            alignment: Alignment.bottomCenter,
            child: SubmitButton(
              text: 'Skip',
              height: height * 0.06,
              width: width * 0.76,
              color: Color(0xFFFFE0D7),
              textColor: Color(0xFFFF6E41),
              path: '/home',
            )),
        SizedBox(height: height * 0.05),
      ]),
    );
  }
}
