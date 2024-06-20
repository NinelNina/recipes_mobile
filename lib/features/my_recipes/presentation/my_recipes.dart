import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/user_recipe/user_recipe_bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/core/domain/services/user_recipe_service.dart';
import 'package:recipes/features/common/widgets/app_bar.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';
import 'package:recipes/features/my_recipes/presentation/widget/my_recipes_template.dart';

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
    //userRecipeBloc.add(FetchUserRecipes(page: null, number: null));
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
                  child: MyRecipesTemplate(),
                ),
                UnauthenticatedWidget(),
              ],
            ),
          ),
        ));
  }
}
