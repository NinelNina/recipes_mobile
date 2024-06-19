import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_state.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'package:recipes/features/common/widgets/app_bar.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';

class MyRecipesScreen extends StatefulWidget {
  @override
  State<MyRecipesScreen> createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> {
  late UserRecipeBloc userRecipeBloc;
  UserRecipeService userRecipeService = UserRecipeService();
  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(authenticationService: AuthenticationService());

  @override
  void initState() {
    super.initState();
    userRecipeBloc = UserRecipeBloc(userRecipeService, authenticationBloc);
    userRecipeBloc.add(FetchUserRecipes());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: userRecipeBloc),
          BlocProvider.value(value: authenticationBloc)
        ],
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
                                  Text('There\'s nothing here :('.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.04),
                                  Container(
                                    width: width * 0.485,
                                    height: height * 0.047,

                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/add');
                                      },
                                      style: ElevatedButton.styleFrom(
                                         backgroundColor: Color(0xFFFF6E41),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text('CREATE RECIPE', style: TextStyle(color: Colors.white),),
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
                UnauthenticatedWidget(),
              ],
            ),
          ),
        ));
  }
}
