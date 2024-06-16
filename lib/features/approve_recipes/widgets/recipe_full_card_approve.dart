import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/services/admin_service.dart';
import 'package:recipes/core/domain/services/recipe_service.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';
import 'package:recipes/features/common/widgets/nav_bar_title_clouse.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_by_id/recipe_state.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_event.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_state.dart';
import 'package:recipes/features/common/recipe_card/full_recipe_card.dart';

class RecipeFullCardApprove extends StatefulWidget {
  final int id;
  final bool isUserRecipe;

  RecipeFullCardApprove({
    required this.id,
    required this.isUserRecipe,
  });

  @override
  State<RecipeFullCardApprove> createState() => _RecipeFullCardApproveState();
}

class _RecipeFullCardApproveState extends State<RecipeFullCardApprove> {
  RecipeBloc recipeBloc = RecipeBloc(RecipeService());
  AdminBloc adminBloc = AdminBloc(adminService: AdminService());

  @override
  void initState() {
    super.initState();
    recipeBloc.add(FetchRecipe(widget.id, widget.isUserRecipe));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: recipeBloc),
        BlocProvider.value(value: adminBloc)
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              NavBarTitleCl(
                title: 'Recipe Details',
                navWidget: BackIconWidget(width: width),
                width: width,
                height: height,
              ),
              Expanded(
                child: BlocBuilder<RecipeBloc, RecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RecipeLoaded) {
                      final recipe = state.recipe;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            FullRecipeCard(
                              id: recipe.id,
                              image: recipe.image,
                              title: recipe.title,
                              type: recipe.type ?? '',
                              readyInMinutes: recipe.readyInMinutes.toString(),
                              isFavouriteRecipe: recipe.isFavouriteRecipe,
                              isUserRecipe: recipe.isUserRecipe,
                              extendedIngredients: recipe.extendedIngredients,
                              steps: recipe.steps,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<AdminBloc>().add(CheckRecipe(
                                          recipeId: recipe.id,
                                          isApproved: false));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(16.0),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<AdminBloc>().add(CheckRecipe(
                                          recipeId: recipe.id,
                                          isApproved: true));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(16.0),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<AdminBloc, AdminState>(
                              builder: (context, adminState) {
                                if (adminState is AdminLoading) {
                                  return CircularProgressIndicator();
                                } else if (adminState is RecipeChecked) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Recipe has been ${adminState is RecipeApproved ? "approved" : "rejected"}'),
                                            backgroundColor:
                                                adminState is RecipeApproved
                                                    ? Colors.green
                                                    : Colors.redAccent));
                                  });
                                } else if (adminState is AdminError) {
                                  return Text('Error: ${adminState.message}');
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (state is RecipeError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return Center(child: Text('Loading...'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
