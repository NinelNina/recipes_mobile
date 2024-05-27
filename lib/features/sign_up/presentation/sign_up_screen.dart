import 'package:flutter/material.dart';
import 'package:recipes/features/app_bar.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/form_input_field.dart';
import 'package:recipes/features/common/widgets/nav_bar.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/nav_bar_title_clouse.dart';

import '../../favourite_button.dart';
import '../../nav_bar_text_search.dart';
import '../../nav_bar_title.dart';
import '../../nav_bar_with_favourites.dart';
import '../../sing_in/presentation/sign_in_screen.dart';

Map<String, String> _users = {};

class SignUp extends StatefulWidget {

  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();


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

  void signUp() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final repeatPassword = _repeatPasswordController.text;

      if (password != repeatPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      if (_users.containsKey(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already exists')),
        );
        return;
      }

      _users[email] = password;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful')),
      );
      if(isFromFavorites){
        userRole = 'user';
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }else {
        userRole = 'user';
        Navigator.pushNamed(context, '/user_profile');
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
            title: 'Sign Up',
            navWidget: BackIconWidget(width: width),
            width: width,
            height: height),
        SizedBox(height: height * 0.05),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(children: [Form(
              key: _formKey,
              child: Column(
                children: [
                  FormInputField(
                    labelText: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    height: height,
                    obscureText: false,
                    validator: validateEmail,
                  ),
                  SizedBox(height: height * 0.01),
                  FormInputField(
                    labelText: 'Password',
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    height: height,
                    obscureText: true,
                    validator: validatePassword,
                  ),
                  SizedBox(height: height * 0.01),
                  FormInputField(
                    labelText: 'Repeat password',
                    controller: _repeatPasswordController,
                    keyboardType: TextInputType.text,
                    height: height,
                    obscureText: true,
                    validator: validatePassword,
                  ),
                ],
              ),
            ),

              SizedBox(height: height * 0.05),
              SubmitButton(
                text: 'Sign Up',
                height: height * 0.06,
                width: width * 0.76,
                color: const Color(0xFFFF6E41),
                textColor: Colors.white,
                onPressed: signUp,
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If you are already registered,',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      ' sign in',
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
        const Spacer(), // Add this to take up the remaining space
        Align(
          alignment: Alignment.bottomCenter,
          child: SubmitButton(
            text: 'Skip',
            height: height * 0.06,
            width: width * 0.76,
            color: const Color(0xFFFFE0D7),
            textColor: const Color(0xFFFF6E41),
            path: "/home",
          ),
        ),
        SizedBox(height: height * 0.05),
      ]),
    );
  }
}
