import 'package:flutter/material.dart';
import 'package:recipes/features/all_recipes/stat.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/dishes_categories/presentation/widgets/category_list.dart';

import '../common/menu_widgets/drawer_item_in_menu.dart';
import '../common/top_row/top_bar.dart';
import '../common/widgets/back_icon_widget.dart';
import '../common/widgets/nav_bar.dart';
import '../nav_bar_title.dart';
import '../nav_bar_title_clouse.dart';

class Statistic extends StatelessWidget {
  const Statistic({super.key, required this.title, required this.categories, required this.answers});

  final String title;
  final List<String> categories;
  final List<String> answers;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return  Scaffold(
            drawer: CustomDrawer(),
            backgroundColor: Colors.white,
            body: Center(
                child: Column(children: [
                  NavBarTitleCl(
                      title: title,
                      navWidget: BackIconWidget(width: width),
                      width: width,
                      height: height,
                  ),
                  SizedBox(height: height * 0.015),
                  Stat(categories: categories, answers: answers, width: width * 0.92, height: height * 0.09)
                ])));
  }
}