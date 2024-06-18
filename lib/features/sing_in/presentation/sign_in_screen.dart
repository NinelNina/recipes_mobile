import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/models/authentication_request.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_event.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_state.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/user_service.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/form_input_field.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/common/widgets/nav_bar_title_clouse.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import '../../common/recipe_card/favourite_button.dart';


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

  final UserService _userService = UserService();

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

  void signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final request = AuthenticationRequest(email, password);
      context
          .read<AuthenticationBloc>()
          .add(AuthenticationButtonPressed(request: request));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return SafeArea(
        child: BlocProvider(
      create: (context) =>
          AuthenticationBloc(authenticationService: AuthenticationService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          NavBarTitleCl(
            title: 'Sign In',
            navWidget: BackIconWidget(width: width),
            width: width,
            height: height,
          ),
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
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) async {
                  if (state is AuthenticationSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Authentication successful'),
                      backgroundColor: Colors.green),
                    );
                    userRole = (await getRole())!;
                    if (userRole == 'user') {
                      if (isFromFavorites) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.popAndPushNamed(context, '/user_profile');
                      }
                    } else {
                      Navigator.popAndPushNamed(context, '/admin_profile');
                    }
                  } else if (state is AuthenticationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${state.error}'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return CircularProgressIndicator(color: Color(0xFFFF6E41));
                  }
                  return SubmitButton(
                    text: 'Sign In',
                    height: height * 0.06,
                    width: width * 0.76,
                    color: Color(0xFFFF6E41),
                    textColor: Colors.white,
                    onPressed: () => signIn(context),
                  );
                },
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
                      AppMetrica.reportEvent('ButtonSignUpFromSignIn Clicked');
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
            ]),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SubmitButton(
              text: 'Skip',
              onPressed: () {
                userRole = '';
                Navigator.pushNamed(context, '/home');
              },
              height: height * 0.06,
              width: width * 0.76,
              color: Color(0xFFFFE0D7),
              textColor: Color(0xFFFF6E41),
              path: '/home',
            ),
          ),
          SizedBox(height: height * 0.05),
        ]),
      ),
    ));
  }

  Future<String?> getRole() async {
    return await _userService.getRole();
  }
}
