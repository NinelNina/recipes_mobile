import 'package:flutter/material.dart';
import 'package:recipes/features/common/widgets/submit_button1.dart';
import 'package:recipes/features/sign_up/presentation/sign_up_screen.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Image.asset(
                  'assets/images/start_screen_img.png',
                  width: width,
                  //height: 511,
                ),
                SizedBox(height: height * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(children: [
                    const Text(
                      'Are you ready to cook tasty food?',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.015),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF808080),
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Recipes App',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: ' will provide you with clear guidance and full recommendations on cooking food just for you.',
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: SubmitButton(
                    text: 'Start cooking',
                    height: height * 0.06,
                    color: Color(0xFFFF6E41),
                    textColor: Colors.white,
                    onPressed: () { },
                  )
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
