import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('All recipes'),
            onTap: () {
              Navigator.pushNamed(context, '/all_recipes');
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Diets'),
            onTap: () {
              Navigator.pushNamed(context, '/diets');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User recipes'),
            onTap: () {
              Navigator.pushNamed(context, '/user_recipes');
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          SizedBox(height: 31.59),
        ],
      ),
    );
  }
}
