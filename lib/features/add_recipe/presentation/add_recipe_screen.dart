import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';

import '../../common/widgets/nav_bar.dart';
import '../../nav_bar_title_clouse.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  List<String> ingredients = ['ЛУК', 'ЧЕСНОК', 'ПЕРЕЦ'];
  List<String> measurements = ['шт', 'г', 'кг', 'л', 'мл'];
  List<String> categories = ['ЗАВТРАК', 'ОБЕД', 'УЖИН'];
  List<Widget> steps = [];
  List<Widget> ingredientsList = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(children: [
                NavBarTitleCl(
                    height: screenHeight,
                    width: screenWidth,
                    title: "Create recipe",
                    navWidget: BackIconWidget(width: screenWidth)),
                Expanded(child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: screenHeight * 0.023),
                  child: Column(
                    children: [
                      buildButton(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.02),
                      buildTitleText('RECIPE NAME'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.06, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('DISH CATEGORY'),
                      SizedBox(height: screenHeight * 0.011),
                      buildDropdown(
                          screenWidth * 0.83, screenHeight * 0.06, categories),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('DESCRIPTION'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.06, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('COOKING TIME'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.06, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('NUMBER OF SERVINGS'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.06, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('INGREDIENTS'),
                      SizedBox(height: screenHeight * 0.011),
                      Column(
                        children: [
                          Column(children: ingredientsList)
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      buildAddIngredientButton(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('PREPARATION INSTRUCTIONS'),
                      SizedBox(height: screenHeight * 0.011),
                      Column(
                        children: [
                          Column(children: steps)
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.011),
                      buildAddStepButton(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.011),
                      //buildConfirmationWidget(screenWidth, screenHeight),
                      SizedBox(
                        width: screenWidth * 0.9,
                        //height: screenHeight * 0.08,
                        child:
                        buildConfirmationWidget(screenWidth, screenHeight),
                      ),
                      SizedBox(height: screenHeight * 0.011),
                      buildButtonsRow(screenWidth * 0.32, screenHeight * 0.047),
                      SizedBox(height: screenHeight * 0.034)
                    ],
                  ),
                )
                )
              ]),
            ));
  }

  Widget buildButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.53,
      height: screenHeight * 0.052,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6E41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {},
        child: const Text(
          'UPLOAD PHOTO',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildTitleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0), // This adds left padding
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildTextField(double width, double height, String hintText) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(double width, double height, List<String> items) {
    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField<String>(
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
        onChanged: (_) {},
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildAddIngredientButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.56,
      height: screenHeight * 0.047,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6E41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          setState(() {
            ingredientsList.add(buildIngredientRow(screenWidth, screenHeight));
          });
        },
        child: const Text(
          '+ ADD INGREDIENT',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildRemoveIngredientButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.05,
      height: screenHeight * 0.026,
      child: GestureDetector(
        onTap: () {
          setState(() {
            ingredientsList.removeLast();
          });
        },
        child: const Icon(
          Icons.remove,
          color: Color(0xFFFF6E41),
        ),
      ),
    );
  }


  Widget buildIngredientRow(double screenWidth, double screenHeight) {
    bool isRemovable = ingredientsList.isNotEmpty;
    return Column(children: [
      SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        child: Row(
          children: [
            buildDropdown(screenWidth * 0.43, screenHeight * 0.06, ingredients),
            SizedBox(width: screenWidth * 0.007),
            buildTextField(screenWidth * 0.18, screenHeight * 0.06, ''),
            SizedBox(width: screenWidth * 0.007),
            buildDropdown(
                screenWidth * 0.19, screenHeight * 0.06, measurements),
            if (isRemovable)
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.024),
                  buildRemoveIngredientButton(screenWidth, screenHeight),
                ],
              ),
          ],
        ),
      ),
      SizedBox(height: screenHeight * 0.004)
    ]);
  }

  Widget buildAddStepButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.53,
      height: screenHeight * 0.047,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6E41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          setState(() {
            steps.add(buildStepTextField(screenWidth, screenHeight));
          });
        },
        child: const Text(
          '+ ADD STEP',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildRemoveStepButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.53,
      height: screenHeight * 0.047,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6E41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          setState(() {
            steps.removeLast();
          });
        },
        child: const Icon(
          Icons.remove,
          color: Color(0xFFFF6E41),
        ),
      ),
    );
  }

  Widget buildStepTextField(width, height) {
    var isRemovable = steps.length > 0;
    return Column(children: [
        SizedBox(
        width: width * 0.9,
        height: height * 0.06,
        child: Row(children: [SizedBox(
            width: width * 0.8,
            height: height * 0.06,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
          if (isRemovable)
            Row(
              children: [
                SizedBox(width: width * 0.024),
                buildRemoveIngredientButton(width, height),
              ],
            ),
        ])),
        SizedBox(height: height * 0.011)
        ]);
  }

  Widget buildConfirmationWidget(double screenWidth, double screenHeight) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked, // Use the boolean variable to set the checkbox value
          checkColor: Colors.white,
          activeColor: const Color(0xFFB3261E),
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue!; // Update the boolean variable when the checkbox state changes
            });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.03,
              child: const Text(
                'Post the recipe',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.77,
              height: screenHeight * 0.04,
              child: const Text(
                'Your recipe will be available to all users after moderation',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.017)
          ],
        )
      ],
    );
  }

  Widget buildButtonsRow(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E41),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'CANCEL',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E41),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              AppMetrica.reportEvent('ButtonSaveRecipe Clicked');
            },
            child: const Text(
              'SAVE',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
