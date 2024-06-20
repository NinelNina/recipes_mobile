import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/favorite_service.dart';
import 'package:recipes/features/add_recipe/presentation/add_recipe_screen.dart';
import 'package:recipes/features/admin_profile/presentation/admin_profile.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/favorite_recipes/presentation/favourite_recipes_screen.dart';
import 'package:recipes/features/my_recipes/presentation/my_recipes.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';
import 'package:recipes/features/splash/presentation/splash_screen.dart';
import 'package:recipes/features/user_recipes/presentation/user_recipes_screen.dart';
import '../../all_recipes/presentation/all_recipes.dart';
import '../../statistics/presentation/statistics.dart';
import '../../approve_recipes/presentation/applications_for_approval.dart';
import '../../dishes_categories/presentation/diets_categories_screen.dart';
import '../../dishes_categories/presentation/dishes_categories_screen.dart';
import '../../main_page/presentation/main_page.dart';
import '../../user_profile/presentation/user_profile.dart';
import '../../sing_in/presentation/sign_in_screen.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    AppMetrica.activate(
        AppMetricaConfig("d90c902e-58ab-4fd1-920c-0ab9858a41db"));

    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationService: AuthenticationService(),
            ),
          ),
          BlocProvider<FavoriteBloc>(
            create: (context) => FavoriteBloc(
              context.read<AuthenticationBloc>(),
              favoriteService: FavoriteService(),
            ),
          ),
        ],
        child: MaterialApp(
            routes: {
              '/splash': (context) => SplashScreen(),
              '/all_recipes': (context) => AllRecipes(),
              '/categories': (context) => DishesCategories(),
              '/diets': (context) => DietsCategories(),
              '/home': (context) => MainPage(),
              '/login': (context) => SignIn(),
              '/sign_up': (context) => SignUp(),
              '/favourites': (context) => FavouriteRecipes(),
              '/user_recipes': (context) => UserRecipesScreen(),
              '/admin_profile': (context) => AdminProfile(),
              '/user_profile': (context) => UserProfileScreen(),
              '/approve': (context) => ApplicationsForApproval(),
              '/my_recipes': (context) => MyRecipesScreen(),
              '/add': (context) => AddRecipe(),
              '/stat': (context) => StatisticScreen(),
            },
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/start_screen_img.png',
                              width: width,
                              //height: 511,
                            ),
                            SizedBox(height: height * 0.015),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
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
                                      TextSpan(
                                          text: 'Recipes App',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text:
                                            ' will provide you with clear guidance and full recommendations on cooking food just for you.',
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
                              path: "/splash",
                            )),
                            //SizedBox(height: height * 0.03),
                          ],
                        ),
                        SizedBox(height: height * 0.03)
                      ],
                    ),
                  )),
            )));
  }
}
