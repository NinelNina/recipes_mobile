import 'package:flutter/material.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

bool isFromFavorites = false;

class FavoritesButton extends StatefulWidget {
  final int index;

  const FavoritesButton({required this.index});

  @override
  _FavoritesButtonState createState() => _FavoritesButtonState();
}

class _FavoritesButtonState extends State<FavoritesButton> {



  final List<bool> isFavorite = [
    true,
    false,
    false,
    false,
    false,
  ];

  void _toggleFavorite() {
    setState(() {
      isFavorite[widget.index] = !isFavorite[widget.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
          isFavorite[widget.index] ? Icons.favorite : Icons.favorite_border,
          color: Color(0xFFF40E36),
        ),
        iconSize: 30,

        onPressed: () async {
          if (userRole != 'user') {
            isFromFavorites = true;
            Navigator.of(context).pushReplacementNamed('/login').then((_) {
              if (isFromFavorites) {
                // After successful login, add recipe to favorites
                setState(() {
                  isFavorite[widget.index] = !isFavorite[widget.index];
                });
                isFromFavorites = false;
              }
            });
          } else {
            // User is authenticated, call the original onPressed function
            _toggleFavorite();
          }
        },
      ),
    );
  }
}
