import 'package:flutter/material.dart';

import '../../sing_in/presentation/sign_in_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    Widget buildLoginButton() {
      if (userRole == 'admin' || userRole == 'user') {
        return ListTile(
          leading: Container(
            width: 30,
            height: 30,
            child: Image.asset('assets/images/frame.png'), // Обновите иконку здесь
          ),
          title: Text('Personal Area'),
          onTap: () {
            if (userRole == 'admin') {
              Navigator.pushNamed(context, '/admin_profile');
            } else if (userRole == 'user') {
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
          SizedBox(width: width * 0.09,),
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
          if (userRole == 'user')
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
          /*ListTile(
            leading: Container(
              width: 30, // задает ширину иконки
              height: 30, // задает высоту иконки
              child: Image.asset('assets/images/login.png'),
            ),
            title: Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),*/
          buildLoginButton(),
        ],
      ),
    );
  }
}
