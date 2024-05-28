import 'package:flutter/material.dart';
import 'package:recipes/core/domain/services/token_service.dart';

class CustomDrawer extends StatelessWidget {
  final TokenService _tokenService = TokenService();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final String userRole = 'user';

    Widget buildLoginButton(String? token) {
      if (token != null) {
        return ListTile(
          leading: Container(
            width: 30,
            height: 30,
            child: Image.asset('assets/images/frame.png'),
          ),
          title: Text('Personal Area'),
          onTap: () {
            if (userRole == 'admin'){
              Navigator.pushNamed(context, '/admin_profile');
            }
            else {
              Navigator.pushNamed(context, '/user_profile');
            }
            },
        );
      } else {
        return ListTile(
          leading: Container(
            width: 30,
            height: 30,
            child: Image.asset('assets/images/login.png'),
          ),
          title: Text('Login'),
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
        );
      }
    }

    return Drawer(
      child: ListView(
        children: [
          SizedBox(width: width * 0.09),
          ListTile(
            leading: Container(
              width: 30, // задает ширину иконки
              height: 30, // задает высоту иконки
              child: Image.asset('assets/images/home.png'),
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Container(
              width: 30, // задает ширину иконки
              height: 30, // задает высоту иконки
              child: Image.asset('assets/images/magnifying-glass.png'),
            ),
            title: Text('All recipes'),
            onTap: () {
              Navigator.pushNamed(context, '/all_recipes');
            },
          ),
          ListTile(
            leading: Container(
              width: 30, // задает ширину иконки
              height: 30, // задает высоту иконки
              child: Image.asset('assets/images/vector.png'),
            ),
            title: Text('Categories'),
            onTap: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          ListTile(
            leading: Container(
              width: 30, // задает ширину иконки
              height: 30, // задает высоту иконки
              child: Image.asset('assets/images/vector.png'),
            ),
            title: Text('Diets'),
            onTap: () {
              Navigator.pushNamed(context, '/diets');
            },
          ),
          ListTile(
            leading: Container(
              width: 30, // задает ширину иконки
              height: 30, // задает высоту иконки
              child: Image.asset('assets/images/magnifying-glass.png'),
            ),
            title: Text('User recipes'),
            onTap: () {
              Navigator.pushNamed(context, '/user_recipes');
            },
          ),
          SizedBox(height: height * 0.52),
          FutureBuilder<String?>(
            future: _tokenService.getToken(),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/error.png'),
                  ),
                  title: Text('Error loading token'),
                );
              } else {
                return buildLoginButton(snapshot.data);
              }
            },
          ),
        ],
      ),
    );
  }
}
