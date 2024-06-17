import 'dart:convert';
import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/models/ingredient_with_units_model.dart';
import 'package:recipes/core/domain/models/meal_type_model.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_state.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_state.dart';
import 'package:recipes/core/domain/services/recipe_info_service.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'package:recipes/features/add_recipe/presentation/widget/ingredient_row.dart';
import 'package:recipes/features/add_recipe/presentation/widget/step_row.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/nav_bar_title_clouse.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  bool isChecked = false;
  List<String> ingredients = [];
  List<String> units = [];
  List<String> mealTypes = [];
  List<IngredientRow> ingredientRows = [];
  List<StepRow> stepRows = [];
  List<IngredientWithUnits> listIngredientObj = [];
  late UserRecipeBloc userRecipeBloc;
  late RecipeInfoBloc recipeInfoBloc;
  File? _imageFile = null;
  String _recipeName = '';
  String? _image = null;
  String? _imageExtension = null;
  String _dishCategory = '';
  String _description = '';
  int _cookingTime = 0;
  int _servings = 0;
  late List<Ingredient> _extendedIngredients = [];
  late List<String> _steps = [];
  late bool isPublish;
  List<GlobalKey<IngredientRowState>> ingredientKeys = [];
  List<GlobalKey<StepRowState>> stepKeys = [];

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
          body: Column(children: [
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
                  _imageFile != null
                      ? Stack(
                          children: [
                            Container(
                              width: screenWidth * 0.53,
                              height: screenHeight * 0.2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5.0,
                              right: 5.0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _imageFile = null;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.delete,
                                      size: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : uploadButton(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  buildTitleText('RECIPE NAME'),
                  SizedBox(height: screenHeight * 0.011),
                  buildTextField(screenWidth * 0.83, screenHeight * 0.06, '',
                      onChanged: (String? newValue) {
                    setState(() {
                      _recipeName = newValue ?? '';
                    });
                  }),
                  SizedBox(height: screenHeight * 0.011),
                  buildTitleText('DISH CATEGORY'),
                  SizedBox(height: screenHeight * 0.011),
                  BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
                    builder: (context, state) {
                      if (state is RecipeInfoLoaded<MealType>) {
                        mealTypes = state.items
                            .map((mealType) => mealType.title.toString())
                            .toList();
                        _dishCategory = mealTypes[0];
                      } else if (state is RecipeInfoLoading) {
                        return CircularProgressIndicator();
                      } else if (state is RecipeInfoError) {
                        return Text(
                            'Error loading meal types: ${state.message}');
                      }
                      return buildDropdown(
                          screenWidth * 0.83, screenHeight * 0.06, mealTypes,
                          onChanged: (String? newValue) {
                        setState(() {
                          _dishCategory = newValue!;
                        });
                      });
                    },
                  ),
                  /*buildDropdown(screenWidth * 0.83, screenHeight * 0.06,
                                  mealTypes, onChanged: (String? newValue) {}),*/
                  SizedBox(height: screenHeight * 0.011),
                  buildTitleText('DESCRIPTION'),
                  SizedBox(height: screenHeight * 0.011),
                  buildTextField(screenWidth * 0.83, screenHeight * 0.06, '',
                      onChanged: (String? newValue) {
                    setState(() {
                      _description = newValue ?? '';
                    });
                  }),
                  SizedBox(height: screenHeight * 0.011),
                  buildTitleText('COOKING TIME'),
                  SizedBox(height: screenHeight * 0.011),
                  buildTextField(screenWidth * 0.83, screenHeight * 0.06, '',
                      onChanged: (String? newValue) {
                    setState(() {
                      _cookingTime = int.tryParse(newValue!) ?? 0;
                    });
                  }),
                  SizedBox(height: screenHeight * 0.011),
                  buildTitleText('NUMBER OF SERVINGS'),
                  SizedBox(height: screenHeight * 0.011),
                  buildTextField(screenWidth * 0.83, screenHeight * 0.06, '',
                      onChanged: (String? newValue) {
                    setState(() {
                      _servings = int.tryParse(newValue!) ?? 0;
                    });
                  }),
                  SizedBox(height: screenHeight * 0.011),
                  buildTitleText('INGREDIENTS'),
                  SizedBox(height: screenHeight * 0.011),
                  BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
                    builder: (context, state) {
                      if (state is RecipeInfoLoading) {
                        return CircularProgressIndicator();
                      } else if (state is RecipeInfoLoaded) {
                        listIngredientObj =
                            (state.items).cast<IngredientWithUnits>();
                        ingredients = state.items
                            .map((ingredient) => ingredient.title.toString())
                            .toList();

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
                    child: buildConfirmationWidget(screenWidth, screenHeight),
                  ),
                  SizedBox(height: screenHeight * 0.011),
                  buildButtonsRow(screenWidth * 0.32, screenHeight * 0.047),
                  SizedBox(height: screenHeight * 0.034)
                ],
              ),
            ))
          ]),
        )));
  }

  Widget uploadButton(double screenWidth, double screenHeight) {
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
      padding: const EdgeInsets.only(left: 35.0),
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

  Widget buildTextField(double width, double height, String hintText,
      {required Function(String? newValue)? onChanged}) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onChanged: onChanged,
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

  Widget buildDropdown(double width, double height, List<String> items,
      {required Function(String? newValue)? onChanged}) {
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
            var key = GlobalKey<IngredientRowState>();
            ingredientKeys.add(key);
            ingredientRows.add(IngredientRow(
              key: key,
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
            var key = GlobalKey<StepRowState>();
            stepKeys.add(key);
            stepRows.add(StepRow(
              key: key,
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
    return Column(children: [
      Row(
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
              onPressed: () {
                Navigator.pop(context);
              },
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
                for (var key in ingredientKeys) {
                  final ingredient = key.currentState?.getCurrentState();
                  _extendedIngredients.add(ingredient!);
                }

                for (var key in stepKeys) {
                  final step = key.currentState?.getCurrentState();
                  _steps.add(step!);
                }

                userRecipeBloc.add(CreateUserRecipe(
                    title: _recipeName,
                    image: _image,
                    imageExtension: _imageExtension,
                    description: _description,
                    category: _dishCategory,
                    readyInMinutes: _cookingTime,
                    extendedIngredients: _extendedIngredients,
                    steps: _steps,
                    isPublish: isChecked));
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
      ),
      BlocBuilder<UserRecipeBloc, UserRecipeState>(
        builder: (context, state) {
          if (state is UserRecipeCreated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Recipe saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            });
            AppMetrica.reportEvent('ButtonSaveRecipe Clicked');
            Navigator.pushNamed(context, '/my_recipes');
          } else if (state is UserRecipeError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving recipe: ${state.message}'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            });
          }
          return Container();
        },
      )
    ]);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() async {
        _imageFile = File(pickedFile.path);
        _image = base64Encode(await _imageFile!.readAsBytes());
        _imageExtension = _extractImageExtension(pickedFile.path);
      });
    }
  }

  String _extractImageExtension(String filePath) {
    final parts = filePath.split('.');
    if (parts.length > 1) {
      return parts.last.toLowerCase();
    }
    return '';
  }
}
