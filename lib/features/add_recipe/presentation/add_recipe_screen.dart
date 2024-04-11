import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';

import '../../common/widgets/nav_bar.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> ingredients = ['ЛУК', 'ЧЕСНОК', 'ПЕРЕЦ'];
  List<String> measurements = ['шт', 'г', 'кг', 'л', 'мл'];
  List<String> categories = ['ЗАВТРАК', 'ОБЕД', 'УЖИН'];
  List<Widget> steps = [];
  List<Widget> ingredientsList = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(children: [
                NavBar(
                    height: screenHeight,
                    width: screenWidth,
                    title: "Create recipe",
                    navWidget: BackIconWidget(width: screenWidth)),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: screenHeight * 0.023),
                  child: Column(
                    children: [
                      buildButton(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.02),
                      buildTitleText('RECIPE NAME'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.056, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('DISH CATEGORY'),
                      SizedBox(height: screenHeight * 0.011),
                      buildDropdown(
                          screenWidth * 0.83, screenHeight * 0.056, categories),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('DESCRIPTION'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.056, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('COOKING TIME'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.056, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('NUMBER OF SERVINGS'),
                      SizedBox(height: screenHeight * 0.011),
                      buildTextField(
                          screenWidth * 0.83, screenHeight * 0.056, ''),
                      SizedBox(height: screenHeight * 0.011),
                      buildTitleText('INGREDIENTS'),
                      SizedBox(height: screenHeight * 0.011),
                      Column(
                        children: [
                          buildIngredientRow(screenWidth, screenHeight),
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
                          buildStepTextField(screenWidth, screenHeight),
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
              ]),
            )));
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

  Widget buildIngredientRow(double screenWidth, double screenHeight) {
    return Column(children: [
      SizedBox(
          width: screenWidth * 0.83,
          height: screenHeight * 0.056,
          child: Row(
            children: [
              buildDropdown(
                  screenWidth * 0.43, screenHeight * 0.06, ingredients),
              SizedBox(width: screenWidth * 0.007),
              buildTextField(screenWidth * 0.18, screenHeight * 0.06, ''),
              SizedBox(width: screenWidth * 0.007),
              buildDropdown(
                  screenWidth * 0.2, screenHeight * 0.04, measurements),
            ],
          )),
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
          '+ ДОБАВИТЬ ШАГ',
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

  Widget buildStepTextField(width, height) {
    return Column( children: [SizedBox(
        width: width * 0.83,
        height: height * 0.056,
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )),
      SizedBox(height: height * 0.011)
    ]
    );
  }

  Widget buildConfirmationWidget(double screenWidth, double screenHeight) {
    return Row(
      children: [
        Checkbox(
          value: false,
          checkColor: Colors.white,
          activeColor: const Color(0xFFB3261E),
          onChanged: (_) {},
        ),
        /*SizedBox(
            width: screenWidth * 0.77,
            height: screenHeight * 0.024,
            child: */
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
                    )),
                SizedBox(height: screenHeight * 0.017)
              ],
            )//)
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
            onPressed: () {},
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
