import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/form_input_field.dart';
import 'package:recipes/features/common/widgets/nav_bar.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        NavBar(
            title: 'Sign Up',
            navWidget: BackIconWidget(width: width),
            width: width,
            height: height),
        SizedBox(height: height * 0.05),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(children: [
              FormInputField(
                  labelText: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  height: height,
                  obscureText: false),
              SizedBox(height: height * 0.01),
              FormInputField(
                  labelText: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  height: height,
                  obscureText: true),
              SizedBox(height: height * 0.01),
              FormInputField(
                  labelText: 'Repeat password',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  height: height,
                  obscureText: true),
              SizedBox(height: height * 0.05),
              SubmitButton(
                text: 'Sign Up',
                height: height * 0.06,
                width: width * 0.76,
                color: const Color(0xFFFF6E41),
                textColor: Colors.white,
                path: "/home",
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
