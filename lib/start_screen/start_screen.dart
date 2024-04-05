import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top, // 5% от высоты экрана
              ),
              //Expanded(child:
              Image.asset(
                'assets/images/start_screen_img.png',
                width: width, // 100% от ширины экрана
                //height: 511,
              ),
              SizedBox(height: height * 0.02), // 2% от высоты экрана
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1), // 10% от ширины экрана
                child: Column(children: [
                  Text(
                    'Are you ready to cook tasty food?',
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: width * 0.06, // 6% от ширины экрана
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02), // 2% от высоты экрана
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xFF808080),
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
              SizedBox(height: height * 0.03), // 3% от высоты экрана
              FilledButton.tonal(
                onPressed: () {
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFF6E41)),
                ),
                child: Text(
                  'Start cooking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.04, // 4% от ширины экрана
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: height * 0.05), // 5% от высоты экрана
            ],
          ),
        ),
      ),
    );
  }
}
