import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

class NavBarWithFavorites extends StatelessWidget {
  const NavBarWithFavorites({
    super.key,
    required this.title,
    required this.navWidget,
    required this.width,
    required this.height,
  });

  final String title;
  final StatelessWidget navWidget;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
          child: Row(
            children: [
              IconButton(
                color: const Color(0xFFFF6E41),
                icon: navWidget,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: Center(
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
              ),
               // добавьте отступ между текстом и правой иконкой
              IconButton(
                icon: Icon(Icons.favorite,
                color: Colors.red),
                onPressed: () {
                  if (userRole == 'user') {
                    Navigator.pushNamed(context, "/favourites");
                  } else {
                    Navigator.pushNamed(context, "/login");
                  }
                },
              ),
            ],
          ),
        ),

      ],
    );
  }
}
