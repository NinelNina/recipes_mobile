import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:recipes/core/domain/services/token_service.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/main_page/presentation/main_page.dart';
import 'package:recipes/features/nav_bar_title.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';


class UserProfileScreen extends StatelessWidget {
  final String profile;
  final TokenService _tokenService = TokenService();

  UserProfileScreen({required this.profile});

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
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: width * 0.044),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: width * 0.073,
                              height: height * 0.034,
                              child: Image.asset('assets/images/vector.png'),
                            ),
                            title: Text(
                              'My recipes',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/my_recipes');
                            },
                          ),
                          ListTile(
                            leading: Container(
                              width: width * 0.073,
                              height: height * 0.034,
                              child: Image.asset('assets/images/Path.png'),
                            ),
                            title: Text(
                              'Favourites',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/favourites');
                            },
                          ),
                          ListTile(
                            leading: Container(
                              width: width * 0.073,
                              height: height * 0.034,
                              child: Image.asset('assets/images/add.png'),
                            ),
                            title: Text(
                              'Add recipe',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/add');
                              AppMetrica.reportEvent('ButtonAddRecipe Clicked');
                            },
                          ),
                          SizedBox(height: height * 0.05),
                          ListTile(
                            leading: Container(
                              width: width * 0.073,
                              height: height * 0.034,
                              child: Image.asset('assets/images/logout.png'),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () async {
                              await _tokenService.deleteToken();
                              userRole = '';
                              //Navigator.push(context, ModalRoute.withName('/login'));
                              //TODO: исправить возврат на экраны
                              Navigator.pushNamed(context, '/login');
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
