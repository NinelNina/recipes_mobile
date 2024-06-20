import 'package:flutter/material.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/features/common/top_row/top_bar.dart';
import 'package:recipes/features/common/widgets/menu_icon_widget.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';
import 'package:recipes/features/favorite_recipes/presentation/widget/favorite_recipes_template.dart';

class FavouriteRecipes extends StatelessWidget {
  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(authenticationService: AuthenticationService());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
              children: [
                Bar(
                  title: 'Favourites',
                  showSearch: false,
                  showIconFavorite: false,
                  navWidget: MenuIconWidget(width: width),
                  width: width,
                  height: height,
                ),
                Expanded(
                  child: FavoriteRecipesTemplate(),
                ),
                UnauthenticatedWidget()
              ],
            )),
    );
  }
}
