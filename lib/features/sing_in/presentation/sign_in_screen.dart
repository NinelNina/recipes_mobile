import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/back_nav_widget.dart';
import 'package:recipes/features/common/widgets/form_input_field.dart';
import 'package:recipes/features/common/widgets/nav_bar.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          NavBar(
              title: 'Sign In',
              navWidget: BackNavWidget(width: width),
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
                SizedBox(height: height * 0.05),
                SubmitButton(
                    text: 'Sign In',
                    height: height * 0.06,
                    width: width * 0.76,
                    color: Color(0xFFFF6E41),
                    textColor: Colors.white),
                SizedBox(height: height * 0.05),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Not registered yet?'),
                      TextSpan(
                          text: ' Sign up',
                          style: TextStyle(color: Color(0xFFFF6E41))),
                    ],
                  ),
                  textAlign: TextAlign.center,
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
              )),
          SizedBox(height: height * 0.05),
        ]),
      ),
    );
  }
}
