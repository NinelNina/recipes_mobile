import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 413,
      height: 53,
      child: Row(
        children: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: const Color(0xFFFF6E41),
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              child: Container(
                width: 287,
                height: 43,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFb613207).withOpacity(1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10.36),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const SizedBox(width: 14.18),
          IconButton(
            icon: const Icon(Icons.favorite),
            color: const Color(0xFFF40E36),
            onPressed: () {
              // Handle favorite button press
            },
          ),
        ],
      ),
    );
  }
}
