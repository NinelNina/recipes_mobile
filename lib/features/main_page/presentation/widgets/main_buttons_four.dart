import 'package:flutter/material.dart';

import 'main_button.dart';

class MainButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            SizedBox(height: height * 0.037),
            MainButton(title: "All recipes", path: "/all_recipes"),
            SizedBox(height: width*0.029),
            MainButton(title: "Categories", path: '/categories',),
          ]),
          SizedBox(width: height * 0.016),
          Column(children: [
            SizedBox(height: height * 0.037),
            MainButton(title: "User recipes", path: '/user_recipes',),
            SizedBox(height: width*0.029),
            MainButton(title: "Diets", path: '/diets',),

          ]),
        ]);

  }
}
