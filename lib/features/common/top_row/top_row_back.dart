import 'package:flutter/material.dart';

class TopRowBack extends StatelessWidget {
  final String recipeName;

  const TopRowBack({
    required this.recipeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      child: Row(
        children: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: const Color(0xFFFF6E41),
                icon: const Icon(Icons.chevron_left_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                recipeName,
                style: TextStyle(
                  color: Color(0xFFFF6E41),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
