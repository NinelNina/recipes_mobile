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
import 'nav_bar_title.dart';

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
    return Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              NavBarTitle(
                title: 'My profile',
                navWidget: MenuIconWidget(width: width),
                width: width,
                height: height,
              ),
              SizedBox(height: height * 0.007),
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
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width *  0.044),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: width * 0.073,
                                height: height * 0.034,
                                child: Image.asset('assets/images/vector.png'), // Используйте вашу собственную иконку выхода
                              ),
                              title: Text('My recipes',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () {
                                Navigator.pushNamed(context, '/my_recipes');
                              },
                            ),
                            ListTile(
                              leading: Container(
                                width: width * 0.073,
                                height: height * 0.034,
                                child: Image.asset('assets/images/Path.png'), // Используйте вашу собственную иконку выхода
                              ),
                              title: Text('Favourites',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () {
                                Navigator.pushNamed(context, '/favourites');
                              },
                            ),
                            ListTile(
                              leading: Container(
                                width: width * 0.073,
                                height: height * 0.034,
                                child: Image.asset('assets/images/add.png'), // Используйте вашу собственную иконку выхода
                              ),
                              title: Text('Add recipe',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () {
                                Navigator.pushNamed(context, '/add');
                              },
                            ),
                            SizedBox(height: height * 0.05),
                            ListTile(
                              leading: Container(
                                width: width * 0.073,
                                height: height * 0.034,
                                child: Image.asset('assets/images/logout.png'), // Используйте вашу собственную иконку выхода
                              ),
                              title: Text('Logout',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () {
                                userRole = '';
                                // Сбросьте любую другую сохраненную информацию о пользователе

                                // Перенаправление на экран входа или главный экран
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => MainPage()),
                                      (Route<dynamic> route) => route.isFirst,
                                );
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
    );
  }
}
