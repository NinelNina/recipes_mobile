import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/core/domain/services/user_service.dart';
import 'package:recipes/features/full_recipe/presentation/full_recipe_screen.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/nav_bar_title_clouse.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

import '../../common/top_row/top_bar.dart';
import '../../common/widgets/back_icon_widget.dart';
import '../../common/widgets/menu_icon_widget.dart';
import '../../main_page/presentation/main_page.dart';
import '../../common/widgets/nav_bar_title.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile();

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final UserService _userService = UserService();
  String _username = '';

  Future<String?> getUsername() async {
    return await _userService.getUsername();
  }

  @override
  void initState() {
    super.initState();

    if (userRole != 'administrator') {
      if (userRole == 'user') {
        Navigator.popAndPushNamed(context, '/user_profile');
      }
      else {
        Navigator.popAndPushNamed(context, '/login');
      }
    }

    getUsername().then((username) {
      setState(() {
        _username = username!;
      });
      if (_username == ''){
        Navigator.popAndPushNamed(context, '/login');
      }
    });
  }

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
              NavBarTitleCl(
                title: 'My profile',
                navWidget: BackIconWidget(width: width),
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
                                _username,
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
                                child: Image.asset('assets/images/vector.png'),
                              ),
                              title: Text('Applications for approval',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () {
                                Navigator.pushNamed(context, '/approve');
                              },
                            ),
                            ListTile(
                              leading: Container(
                                width: width * 0.073,
                                height: height * 0.034,
                                child: Image.asset('assets/images/shuffle.png'), // Используйте вашу собственную иконку выхода
                              ),
                              title: Text('Application statistics',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () {
                                Navigator.pushNamed(context, '/stat');
                              },

                            ),
                            SizedBox(height: height * 0.05),
                            ListTile(
                              leading: Container(
                                width: width * 0.073,
                                height: height * 0.034,
                                child: Image.asset('assets/images/logout.png'),
                              ),
                              title: Text('Logout',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              onTap: () async {
                                userRole = '';
                                await _userService.deleteToken();
                                await _userService.deleteUsername();
                                await _userService.deleteRole();
                                Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
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
