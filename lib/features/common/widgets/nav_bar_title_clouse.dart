import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/features/sing_in/presentation/sign_in_screen.dart';

class NavBarTitleCl extends StatelessWidget {
  const NavBarTitleCl({
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
          constraints: BoxConstraints(
            minHeight: 0,
          ),
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
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFF6E41),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      height: 1.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 50)
            ],
          ),
        ),

      ],
    );
  }
}
