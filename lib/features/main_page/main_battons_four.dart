import 'package:flutter/material.dart';

import 'main_batton.dart';

class MainButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            SizedBox(height: width*0.029),
            MainButton(title: "All recipes", path: "/all_recipes"),
            SizedBox(height: width*0.029),
            MainButton(title: "Categories", path: '/categories',),
          ]),
          SizedBox(width: width*0.029),
          Column(children: [
            SizedBox(height: width*0.029),
            MainButton(title: "User recipes", path: '/user_recipes',),
            SizedBox(height: width*0.029),
            MainButton(title: "Diets", path: '/diets',),

          ]),
        ]);

  }
}
