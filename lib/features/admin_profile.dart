import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/all_resipes/recipe_ingredients.dart';
import 'package:recipes/features/common/menu_widgets/drawer_item_in_menu.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/top_row/top_row.dart';
import 'package:recipes/features/common/widgets/%D1%81ustomDrawer.dart';

import 'common/top_row/top_bar.dart';
import 'common/widgets/menu_icon_widget.dart';

class AdminProfile extends StatelessWidget {
  final String profile;

  const AdminProfile({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return MaterialApp(
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
                              title: Text('Applications for approval'),
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.list),
                              title: Text('application statistics'),
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
