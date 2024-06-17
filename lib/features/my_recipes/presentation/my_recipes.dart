import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_state.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'package:recipes/features/common/widgets/app_bar.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';

class MyRecipesScreen extends StatefulWidget {
  @override
  State<MyRecipesScreen> createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> {
  late UserRecipeBloc userRecipeBloc;
  UserRecipeService userRecipeService = UserRecipeService();

  @override
  void initState() {
    super.initState();
    userRecipeBloc = UserRecipeBloc(userRecipeService);
    userRecipeBloc.add(FetchUserRecipes());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return BlocProvider.value(
        value: userRecipeBloc,
        child: SafeArea(
          child: Scaffold(
            drawer: CustomDrawer(),
            body: Column(
              children: [
                NavBarWithAddAndSearch(
                  title: 'My recipes',
                  navWidget: MenuIconWidget(width: width),
                  width: width,
                  height: height,
                ),
                Expanded(
                  child: BlocBuilder<UserRecipeBloc, UserRecipeState>(
                    builder: (context, state) {
                      if (state is UserRecipeLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFFFF6E41)));
                      } else if (state is UserRecipeLoaded) {
                        final recipes = state.recipes;
                        return recipes.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(height: height * 0.02),
                                  Text('There\'s nothing here :('),
                                  SizedBox(height: height * 0.04),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/add');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                      child: Text('Add Recipe'),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: recipes.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == recipes.length) {
                                    return Container(
                                      width: width * 0.76,
                                      height: height * 0.06,
                                    );
                                  } else {
                                    final recipe = recipes[index];
                                    return Column(
                                      children: [
                                        Center(
                                          child: RecipeCard(
                                            image: recipe.image,
                                            recipeName: recipe.title,
                                            isFavorite:
                                                recipe.isFavouriteRecipe,
                                            id: recipe.id,
                                            isUserRecipe: recipe.isUserRecipe,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              );
                      } else if (state is UserRecipeError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
