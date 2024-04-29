import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final String path;

  const MainButton({
    required this.title,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Container(
        width: width * 0.44,
        height: height * 0.12,
        decoration: BoxDecoration(
          color: Color(0xFFFF6E41),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.17),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(title,
              style: TextStyle(
              color: Color(0xFFFFFFFF),
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),),
        ),
      ),
    );

  }
}
