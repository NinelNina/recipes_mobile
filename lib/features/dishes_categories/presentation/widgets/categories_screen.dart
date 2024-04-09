import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/dishes_categories/presentation/widgets/category_list.dart';

import '../../../common/widgets/nav_bar.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.title, required this.categories});

  final String title;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Column(children: [
                NavBar(
                  title: title,
                  navWidget: MenuIconWidget(width: width),
                  width: width,
                  height: height),
                  SizedBox(height: height * 0.015),
                  CategoryList(categories: categories, width: width * 0.92, height: height * 0.06)
            ]))));
  }
}
