import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_event.dart';
import 'package:recipes/core/domain/presentation/bloc/favorite/add_to_favorite/favorite_state.dart';
import 'package:recipes/core/domain/services/user_service.dart';

bool isFromFavorites = false;

class FavoritesButton extends StatefulWidget {
  final String recipeId;
  final bool isUserRecipe;
  final bool isFavorite;

  const FavoritesButton({
    required this.recipeId,
    required this.isUserRecipe,
    required this.isFavorite,
  });

  @override
  _FavoritesButtonState createState() => _FavoritesButtonState();
}

class _FavoritesButtonState extends State<FavoritesButton> {
  final UserService _tokenService = UserService();
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      context.read<FavoriteBloc>().add(AddRecipeToFavorite(
          recipeId: widget.recipeId, isUserRecipe: widget.isUserRecipe));
    } else {
      context.read<FavoriteBloc>().add(DeleteRecipeFromFavorite(
          recipeId: widget.recipeId, isUserRecipe: widget.isUserRecipe));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteLoaded) {
          setState(() {
            isFavorite = widget.isFavorite;
          });
        } else if (state is FavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return CircularProgressIndicator();
        } else {
          return Container(
              width: width * 0.158,
              height: height * 0.069,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.17),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Color(0xFFF40E36),
                ),
                iconSize: 30,
                onPressed: () async {
                  final token = await _tokenService.getToken();
                  if (token == null) {
                    isFromFavorites = true;
                    Navigator.of(context)
                        .pushReplacementNamed('/login')
                        .then((_) {
                      if (isFromFavorites) {
                        _toggleFavorite();
                        isFromFavorites = false;
                      }
                    });
                  } else {
                    _toggleFavorite();
                  }
                },
              ));
        }
      },
    );
  }
}
