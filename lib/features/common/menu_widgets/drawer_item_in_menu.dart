import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const DrawerItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 218,
      height: 52.41,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Text(text),
        ],
      ),
    );
  }
}
