import 'package:flutter/material.dart';
import 'package:recipes/core/domain/services/user_service.dart';

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
    UserService _tokenService = UserService();
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
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () async {
                  final token = await _tokenService.getToken();
                  if (token != null) {
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
