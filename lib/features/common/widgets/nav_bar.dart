import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes/features/common/widgets/back_icon_widget.dart';

class NavBar extends StatelessWidget {
  const NavBar({
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
            IconButton(
              color: const Color(0xFFFF6E41),
              icon: navWidget,
              onPressed: () {
                Navigator.pop(context);
              }
              ),

              Text(title,
                  style: const TextStyle(
                      color: Color(0xFFFF6E41),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: width * 0.15),
            ],
          )))
    ]);
  }
}
