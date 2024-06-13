import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes/core/domain/models/ingredient_with_units_model.dart';
import 'package:recipes/core/domain/models/meal_type_model.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_state.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_bloc.dart';
import 'package:recipes/core/domain/services/recipe_info_service.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'package:recipes/features/add_recipe/presentation/widget/ingredient_row.dart';
import 'package:recipes/features/add_recipe/presentation/widget/step_row.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/nav_bar_title_clouse.dart';
//import 'package:image_picker/image_picker.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  List<String> ingredients = [];
  List<String> units = [];
  List<String> mealTypes = [];
  List<IngredientRow> ingredientRows = [];
  List<StepRow> stepRows = [];
  List<IngredientWithUnits> listIngredientObj = [];
  late UserRecipeBloc userRecipeBloc;
  late RecipeInfoBloc recipeInfoBloc;
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    UserRecipeService userRecipeService = UserRecipeService();
    RecipeInfoService recipeInfoService = RecipeInfoService();
    userRecipeBloc = UserRecipeBloc(userRecipeService);
    recipeInfoBloc = RecipeInfoBloc(recipeInfoService: recipeInfoService);
    recipeInfoBloc.add(FetchMealTypes());
    recipeInfoBloc.add(FetchIngredients());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: recipeInfoBloc),
          BlocProvider.value(value: userRecipeBloc),
        ],
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Column(children: [
                    NavBarTitleCl(
                        height: screenHeight,
                        width: screenWidth,
                        title: "Create recipe",
                        navWidget: BackIconWidget(width: screenWidth)),
                    Expanded(
                        child: SingleChildScrollView(
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
                              BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
                                builder: (context, state) {
                                  if (state is RecipeInfoLoaded<MealType>) {
                                    mealTypes = state.items.map((mealType) => mealType.title.toString().toUpperCase()).toList();
                                  } else if (state is RecipeInfoLoading) {
                                    return CircularProgressIndicator();
                                  } else if (state is RecipeInfoError) {
                                    return Text('Error loading meal types: ${state.message}');
                                  }
                                  return buildDropdown(screenWidth * 0.83, screenHeight * 0.06,
                                      mealTypes, onChanged: (String? newValue) {});
                                    },
                              ),
                              /*buildDropdown(screenWidth * 0.83, screenHeight * 0.06,
                                  mealTypes, onChanged: (String? newValue) {}),*/
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
                              BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
                                builder: (context, state) {
                                  if (state is RecipeInfoLoading) {
                                    return CircularProgressIndicator();
                                  } else if (state is RecipeInfoLoaded) {
                                    listIngredientObj = (state.items).cast<IngredientWithUnits>();
                                    ingredients = state.items.map((ingredient) => ingredient.title.toString()).toList();

                                    return Column(
                                      children: ingredientRows,
                                    );
                                  } else if (state is RecipeInfoError) {
                                    return Text(
                                        'Error loading ingredients: ${state.message}');
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              buildAddIngredientButton(screenWidth, screenHeight),
                              SizedBox(height: screenHeight * 0.011),
                              buildTitleText('PREPARATION INSTRUCTIONS'),
                              SizedBox(height: screenHeight * 0.011),
                              Column(
                                children: stepRows,
                              ),
                              SizedBox(height: screenHeight * 0.011),
                              buildAddStepButton(screenWidth, screenHeight),
                              SizedBox(height: screenHeight * 0.011),
                              SizedBox(
                                width: screenWidth * 0.9,
                                child: buildConfirmationWidget(
                                    screenWidth, screenHeight),
                              ),
                              SizedBox(height: screenHeight * 0.011),
                              buildButtonsRow(
                                  screenWidth * 0.32, screenHeight * 0.047),
                              SizedBox(height: screenHeight * 0.034)
                            ],
                          ),
                        ))
                  ]),
                ))));
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
        onPressed: () {
          _pickImage(ImageSource.gallery);
        },
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

  Widget buildDropdown(double width, double height, List<String> items, {required Function(String? newValue)? onChanged}) {
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
        onChanged: onChanged,
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
            ingredientRows.add(IngredientRow(
              key: UniqueKey(),
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              ingredients: ingredients,
              listIngredientObj: listIngredientObj,
              onRemove: (key) {
                setState(() {
                  ingredientRows.removeWhere((row) => row.key == key);
                });
              },
            ));
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
            stepRows.add(StepRow(
              key: UniqueKey(),
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onRemove: (key) {
                setState(() {
                  stepRows.removeWhere((row) => row.key == key);
                });
              },
            ));
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

  Widget buildConfirmationWidget(double screenWidth, double screenHeight) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          checkColor: Colors.white,
          activeColor: const Color(0xFFB3261E),
          onChanged: (bool? newValue) {
            setState(() {
              isChecked = newValue!;
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
              //userRecipeBloc.add(CreateUserRecipe(title: '', image: '', imageExtension: '', description: '', category: '', readyInMinutes: 0, extendedIngredients: [], steps: [], isPublish: isChecked));
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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      // Handle the picked image
      // For example, you can set it to a state variable to display it in the UI
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}