import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  List<String> ingredients = [
    '1 cup flour',
    '2 eggs',
    '1/2 cup sugar',
    '1 tsp baking powder',
    '1/2 tsp salt',
    '1/2 cup milk',
    '1/2 cup vegetable oil',
    '1 tsp vanilla extract'
  ];

  List<String> instructions = [
    'Preheat oven to 350°F (175°C).',
    'In a large bowl, combine flour, sugar, baking powder, and salt.',
    'Add eggs, milk, oil, and vanilla extract to the bowl and mix well.',
    'Pour batter into a greased 9x5 inch loaf pan.',
    'Bake for 50-60 minutes, or until a toothpick inserted into the center comes out clean.',
    'Let cool in pan for 10 minutes, then remove from pan and let cool completely on a wire rack.'
  ];

  int portions = 1;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void calculatePortions() {
    setState(() {
      ingredients = [
        '${(1 * portions).toStringAsFixed(0)} cup flour',
        '${(2 * portions).toStringAsFixed(0)} eggs',
        '${(1 / 2 * portions).toStringAsFixed(2)} cup sugar',
        '${(1 * portions).toStringAsFixed(0)} tsp baking powder',
        '${(1 / 2 * portions).toStringAsFixed(2)} tsp salt',
        '${(1 / 2 * portions).toStringAsFixed(2)} cup milk',
        '${(1 / 2 * portions).toStringAsFixed(2)} cup vegetable oil',
        '${(1 * portions).toStringAsFixed(0)} tsp vanilla extract'
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    double leftButtonWidth = width * 0.277;
    double rightButtonWidth = width * 0.449;
    double ovalHeight = height * 0.051;
    double verticalOffset = 3;

    return Column(
      children: [
        Container(
          width: leftButtonWidth + rightButtonWidth + verticalOffset * 4,
          height: verticalOffset * 2 + ovalHeight,
          decoration: BoxDecoration(
            color: Color(0xFFE3E8EB),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      _animationController.forward(from: 0);
                    },
                    child: Container(
                      width: leftButtonWidth,
                      height: verticalOffset * 2 + ovalHeight,
                      decoration: BoxDecoration(
                        color: Color(0xFFE3E8EB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF5E5E5E),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      _animationController.forward(from: 1);
                    },
                    child: Container(
                      width: rightButtonWidth ,
                      height: verticalOffset * 2 + ovalHeight,
                      decoration: BoxDecoration(
                        color: Color(0xFFE3E8EB),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Instructions',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF5E5E5E),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: selectedIndex == 0 ? 4 : leftButtonWidth + 8,
                width: selectedIndex == 0 ? leftButtonWidth : rightButtonWidth,
                top: verticalOffset,
                child: Container(
                  height: ovalHeight,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        selectedIndex == 0 ? 'Ingredients' : 'Instructions',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF000000),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.008),
        selectedIndex == 0
            ? Column(
          children: [
            Row(children: [
              SizedBox(width: width * 0.036),
              Icon(Icons.circle, color: Color(0xFFFF6E41), size: 10),
              SizedBox(width: width * 0.024),
              Text("Portions",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),),
              SizedBox(width: width * 0.041),
              Expanded(
                child: Container(
                  width: width * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF6E41), // цвет обводки
                          width: 2, // толщина обводки
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF000000), // цвет обводки
                          width: 0.5,
                          style: BorderStyle.solid,// толщина обводки
                        ),
                      ),

                    ),
                    onChanged: (value) {
                      setState(() {
                        portions = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
              ),
            ]),
            SizedBox(height: height * 0.007),
            Container(
              width: width * 0.857,
              height: height * 0.048,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFFFF6E41)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                onPressed: calculatePortions,
                child: Text('Calculate',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.circle,
                        color: Color(0xFFFF6E41), size: 7),
                    title: Text(ingredients[index],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),),
                  );
                }),
          ],
        )
            : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: instructions.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading:
              Icon(Icons.circle, color: Color(0xFFFF6E41), size: 7),
              title: Text(instructions[index],
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),),
            );
          },
        ),
      ],
    );
  }
}
