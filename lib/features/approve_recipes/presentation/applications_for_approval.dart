import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_event.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_state.dart';
import 'package:recipes/core/domain/services/admin_service.dart';
import 'package:recipes/features/approve_recipes/widgets/recipe_full_card_approve.dart';
import 'package:recipes/features/common/recipe_card/recipe_card.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';

import '../../common/widgets/back_icon_widget.dart';
import '../../common/widgets/nav_bar_text_search.dart';

class ApplicationsForApproval extends StatefulWidget {
  @override
  _ApplicationsForApprovalState createState() => _ApplicationsForApprovalState();
}

class _ApplicationsForApprovalState extends State<ApplicationsForApproval> {
  AdminBloc adminBloc = new AdminBloc(adminService: AdminService());

  @override
  void initState() {
    super.initState();
    adminBloc.add(FetchRecipesToCheck(page: 0, number: 10));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return BlocProvider.value(value: adminBloc,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              NavBarWithTextAndSearh(
                title: 'Application for approval',
                navWidget: BackIconWidget(width: width),
                width: width,
                height: height,
              ),
              Expanded(
                child: BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is AdminLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RecipesLoaded) {
                      return ListView.builder(
                        itemCount: state.recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final recipe = state.recipes[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeFullCardApprove(
                                      id: recipe.id,
                                      isUserRecipe: true,
                                    ),
                                  ),
                              );
                            },
                            child: RecipeCard(
                              image: recipe.image,
                              recipeName: recipe.title,
                              isFavorite: recipe.isFavouriteRecipe ?? false,
                              id: recipe.id,
                              isUserRecipe: true,
                            ),
                          );
                        },
                      );
                    } else if (state is AdminError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return Center(child: Text('Press a button to load data'));
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
