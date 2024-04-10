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
        '${(1/2 * portions).toStringAsFixed(2)} cup sugar',
        '${(1 * portions).toStringAsFixed(0)} tsp baking powder',
        '${(1/2 * portions).toStringAsFixed(2)} tsp salt',
        '${(1/2 * portions).toStringAsFixed(2)} cup milk',
        '${(1/2 * portions).toStringAsFixed(2)} cup vegetable oil',
        '${(1 * portions).toStringAsFixed(0)} tsp vanilla extract'
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    double leftButtonWidth = 114.0;
    double rightButtonWidth = 185.0;
    double ovalHeight = 42;
    double verticalOffset = (48 - ovalHeight) / 2;

    return Column(
      children: [
        Container(
          width: 311,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(46),
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
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Ingredients'),
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
                      width: rightButtonWidth,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Instructions'),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        selectedIndex == 0 ? 'Ingredients' : 'Instructions',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 7),
        selectedIndex == 0
            ? Column(
          children: [
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.circle,
                    color: Color(0xFFFF6E41),
                    size: 10),
                SizedBox(width: 10),
                Text("Portions"),
                SizedBox(width: 17.03),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        portions = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                ]
            ),
                SizedBox(height: 6),
                Container(
                  width: 353,
                height: 42.57,
                child:ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),),
                  ),
                  onPressed: calculatePortions,
                  child: Text('Calculate'),
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
                      color: Color(0xFFFF6E41),
                      size: 10),
                    title: Text(ingredients[index]),
                  );
                }
            ),
          ],
        )
            : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: instructions.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.circle,
                color: Color(0xFFFF6E41),
                size: 10),
              title: Text(instructions[index]),
            );
          },
        ),
      ],
    );
  }
}
