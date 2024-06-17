import 'package:flutter/material.dart';
import 'package:recipes/features/recipes_by_diets_and_categories/presentation/recipes_by_diets_and_categories_screen.dart';

class CategoryField extends StatelessWidget {
  final String text;
  final bool isDiet;
  final double width;
  final double height;

  const CategoryField(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
        required this.isDiet});

  @override
  Widget build(BuildContext context) {
    String? diet = null;
    String? type = null;
    if (isDiet){
      diet = text;
    } else {
      type = text;
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecipesByDietsAndCategoriesScreen(diet: diet, type: type,)));
            //Navigator.pushNamed(context, '/categories_diets');
    },
    child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5A5A5A).withOpacity(0.17),
                offset: const Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              )
            ]),
        padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: height * 0.2),
        child: Text(text,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ))));
  }
}
