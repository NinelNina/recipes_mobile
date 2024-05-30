import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const CategoryField(
      {super.key,
      required this.text,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

            Navigator.pushNamed(context, '/categories_diets');

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
