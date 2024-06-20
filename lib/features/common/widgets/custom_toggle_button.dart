import 'package:flutter/material.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';

class CustomToggleButton extends StatefulWidget {
  final List<Ingredient> extendedIngredients;
  final List<String>? steps;

  const CustomToggleButton(
      {super.key, required this.extendedIngredients, required this.steps});

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String> ingredients = [];

  void parseIngredients() {
    widget.extendedIngredients.forEach((element) {
      String result;
      if (element.amount.truncate() == element.amount) {
        result = element.amount.truncate().toString();
      } else {
        result = element.amount.toStringAsFixed(2);
      }

      String tmp_unit = '';
      if (element.unit.isNotEmpty) {
        tmp_unit = element.unit + ' ';
      }

      ingredients.add(result + ' ' + tmp_unit + element.name);
    });
  }

  int portions = 1;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    parseIngredients();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void calculatePortions() {
    setState(() {
      ingredients = [];
      widget.extendedIngredients.forEach((element) {
        var tmp_amount = portions * element.amount;
        String result;
        if (tmp_amount.truncate() == tmp_amount) {
          result = tmp_amount.truncate().toString();
        } else {
          result = tmp_amount.toStringAsFixed(2);
        }
        ingredients.add(result + ' ' + element.unit + ' ' + element.name);
      });
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
                      width: rightButtonWidth,
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
                    SizedBox(width: width * 0.074),
                    Container(
                      width: width * 0.105,
                      height: height * 0.043,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        width: width * 0.044,
                        height: height * 0.018,
                        'assets/images/icon_group.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: width * 0.024),
                    Text(
                      "Portions",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF000000),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: width * 0.041),
                    Container(
                      width: width * 0.05,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF6E41),
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
                              width: 0.5,
                              style: BorderStyle.solid,
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
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: width * 0.049),
                          child: ListTile(
                            leading: Icon(Icons.circle,
                                color: Color(0xFFFF6E41), size: 7),
                            title: Text(
                              ingredients[index],
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              )
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.steps!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: width * 0.049),
                    child: ListTile(
                      leading: Icon(Icons.circle,
                          color: Color(0xFFFF6E41), size: 14),
                      title: Text(
                        widget.steps![index],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
