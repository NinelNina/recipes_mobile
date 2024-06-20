import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const DrawerItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return SizedBox(
      width: width * 0.53,
      height: height * 0.06,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: width * 0.04),
          Text(text),
        ],
      ),
    );
  }
}
