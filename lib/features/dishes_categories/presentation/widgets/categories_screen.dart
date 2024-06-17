import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/dishes_categories/presentation/widgets/category_list.dart';
import '../../../common/widgets/custom_drawer.dart';
import '../../../common/widgets/nav_bar_title.dart';

class Categories extends StatelessWidget {
  const Categories(
      {super.key,
      required this.title,
      required this.categories,
      required this.isDiet});

  final String title;
  final List<String> categories;
  final bool isDiet;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBarTitle(
              title: title,
              navWidget: MenuIconWidget(width: width),
              width: width,
              height: height,
            ),
            SizedBox(height: height * 0.015),
            CategoryList(
              categories: categories,
              width: width * 0.92,
              height: height * 0.06,
              isDiet: isDiet,
            ),
          ],
        ),
      ),
    );
  }
}
