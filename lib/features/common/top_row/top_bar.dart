import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';

class Bar extends StatelessWidget {
  const Bar({
    super.key,
    required this.title,
    required this.showSearch,
    required this.showIconFavorite,
    required this.navWidget,
    required this.width,
    required this.height,
  });

  final String title;
  final bool showSearch;
  final bool showIconFavorite;
  final StatelessWidget navWidget;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: MediaQuery.of(context).padding.top,
      ),
      Container(
          width: width,
          height: height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: navWidget,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                  if (showSearch)
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
                    )
                  else Text(title,
                      style: const TextStyle(
                          color: Color(0xFFFF6E41),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  if (showIconFavorite)
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: const Color(0xFFF40E36),
                    onPressed: () {
                      // Handle favorite button press
                    },
                  )
                  else SizedBox(width: width * 0.15),
                ],
              )))
    ]);
  }
}
