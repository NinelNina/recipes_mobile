import 'package:flutter/material.dart';
import 'package:recipes/features/add_recipe/presentation/add_recipe_screen.dart';
import 'package:recipes/features/admin_profile.dart';
import 'package:recipes/features/categories_and_diets.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/favourites.dart';
import 'package:recipes/features/my_recipes.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';
import 'package:recipes/features/user_recipes.dart';

import '../../all_recipes/all_recipes.dart';
import '../../all_recipes/stat.dart';
import '../../all_recipes/statistics.dart';
import '../../applications_for_approval.dart';
import '../../dishes_categories/presentation/diets_categories_screen.dart';
import '../../dishes_categories/presentation/dishes_categories_screen.dart';
import '../../main_page/presentation/main_page.dart';
import '../../profile.dart';
import '../../sing_in/presentation/sign_in_screen.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    final List<String> recipes = [
      'RecipeOrDiet 1',
      'RecipeOrDiet 2',
      'RecipeOrDiet 3',
      'RecipeOrDiet 4',
      'RecipeOrDiet 5',
      'RecipeOrDiet 6',

    ];

    final List<String> images = [
      'assets/images/imageRecipe.jpeg',
      'assets/images/imageRecipe.jpeg',
      'assets/images/imageRecipe.jpeg',
      'assets/images/imageRecipe.jpeg',
      'assets/images/imageRecipe.jpeg',
      'assets/images/imageRecipe.jpeg',
    ];

    final List<bool> isFavorite = [
      true,
      false,
      false,
      false,
      false,
      false,
    ];

    final List<String> cookingTime = [
      '30 min',
      '1 hour',
      '2 hours',
      '3 hours',
      '4 hours',
      '4 hours',
    ];

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
        '/admin_profile': (context) => AdminProfile(profile: "admin"),
        '/user_profile': (context) => Profile(profile: "user",),
        '/approve': (context) => ApplicationsForApproval(),
        '/my_recipes': (context) => MyRecipes(),
        '/add': (context) => AddRecipe(),
        '/categories_diets': (context) => CategoriesAndDiens(images: images, recipes: recipes, cookingTime: cookingTime, isFavorite: isFavorite),
        '/stat': (context) => Statistic(title: 'Statistics', categories: ['Total registered users:','Recipes created by users:','The most popular diet (last month):'],answers: ['200','28','vegan'],),
      },
      debugShowCheckedModeBanner: false,
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
