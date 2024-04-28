import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/fevourites.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';
import 'package:recipes/features/user_recipes.dart';

import '../../all_resipes/all_recipes.dart';
import '../../dishes_categories/presentation/diets_categories_screen.dart';
import '../../dishes_categories/presentation/dishes_categories_screen.dart';
import '../../main_page/main_page.dart';
import '../../sing_in/presentation/sign_in_screen.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MaterialApp(
      routes: {
        '/all_recipes': (context) => All_recipes(),
        '/categories': (context) => DishesCategories(),
        '/diets': (context) => DietsCategories(),
        '/home': (context) => MainPage(),
        '/login': (context) => SignIn(),
        '/sign_up': (context) => SignUp(),
        '/favourites': (context) => Favourite_recipes(),
        '/user_recipes': (context) => User_recipes(),
      },
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Image.asset(
                  'assets/images/start_screen_img.png',
                  width: width,
                  //height: 511,
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(children: [
                    const Text(
                      'Are you ready to cook tasty food?',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.015),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF808080),
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Recipes App',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: ' will provide you with clear guidance and full recommendations on cooking food just for you.',
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: SubmitButton(
                    text: 'Start cooking',
                    height: height * 0.06,
                    color: Color(0xFFFF6E41),
                    textColor: Colors.white,
                      path: "/login",
                  )
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
