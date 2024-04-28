import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/all_resipes/recipe_ingredients.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/%D1%81ustomDrawer.dart';
import 'package:recipes/features/my_recipes.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';
import 'package:recipes/features/user_recipes.dart';

import 'all_resipes/all_recipes.dart';
import 'common/top_row/top_bar.dart';
import 'common/widgets/menu_icon_widget.dart';
import 'dishes_categories/presentation/diets_categories_screen.dart';
import 'dishes_categories/presentation/dishes_categories_screen.dart';
import 'fevourites.dart';
import 'main_page/main_page.dart';

class Profile extends StatelessWidget {
  final String profile;

  const Profile({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return MaterialApp(
      routes: {
        '/all_recipes': (context) => All_recipes(),
        '/categories': (context) => DishesCategories(),
        '/diets': (context) => DietsCategories(),
        '/home': (context) => MainPage(),
        '/login': (context) => SignIn(),
        '/sign_up': (context) => SignUp(),
        '/favourites': (context) => Favourite_recipes(),
        '/user_recipes': (context) => User_recipes(),
        '/my_recipes': (context) => MyRecipes(),
      },
      home: Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Bar(
                title: 'My profile',
                showSearch: false,
                showIconFavorite: false,
                navWidget: MenuIconWidget(width: width),
                width: width,
                height: height,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      Center(
                        child: Container(
                            width: width * 0.98,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF6E41),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                profile,
                              ),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width *  0.094),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text('My recipes'),
                              onTap: () {
                                Navigator.pushNamed(context, '/my_recipes');
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
                              leading: Icon(Icons.list),
                              title: Text('All recipes'),
                              onTap: () {
                                Navigator.pushNamed(context, '/all_recipes');
                              },
                            ),
                            SizedBox(height: height * 0.05),
                            ListTile(
                              leading: Icon(Icons.list),
                              title: Text('All recipes'),
                              onTap: () {
                                Navigator.pushNamed(context, '/all_recipes');
                              },
                            ),
                          ],
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
