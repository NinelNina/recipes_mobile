import 'package:flutter/material.dart';
import 'package:recipes/features/admin_profile.dart';
import 'package:recipes/features/all_recipes/statistics.dart';
import 'package:recipes/features/dishes_categories/presentation/diets_categories_screen.dart';
import 'package:recipes/features/dishes_categories/presentation/dishes_categories_screen.dart';
import 'package:recipes/features/dishes_categories/presentation/stat_field.dart';
import 'package:recipes/features/dishes_categories/presentation/widgets/categories_screen.dart';
import 'package:recipes/features/my_recipes.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';
import 'package:recipes/features/start/presentation/start_screen.dart';
import 'package:recipes/features/all_recipes/all_recipes.dart';
import 'package:recipes/features/all_recipes/full_recipe_screen.dart';

import 'features/applications_for_approval.dart';
import 'features/main_page/presentation/main_page.dart';
import 'features/user_profile.dart';
import 'features/recipe_ingredients_approve.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(All_recipes());
  //runApp(MyRecipes());
  //runApp(ApplicationsForApproval());
  //runApp(Profile(profile: "user@gmail.com",));
  //runApp(AdminProfile(profile: "user@gmail.com",));
  //runApp(MainPage());
  //runApp(StatFell());
  //runApp(Recipe_ingredients());
  runApp(const Start());

}

