import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberedCircleIcon extends StatelessWidget {
  final int number;
  final Color color;

  const NumberedCircleIcon({required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
