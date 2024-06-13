import 'package:flutter/material.dart';
import 'package:recipes/core/domain/models/ingredient_with_units_model.dart';

class IngredientRow extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final List<String> ingredients;
  final List<IngredientWithUnits> listIngredientObj;
  final Function(Key) onRemove;

  const IngredientRow({
    required Key key,
    required this.screenWidth,
    required this.screenHeight,
    required this.ingredients,
    required this.listIngredientObj,
    required this.onRemove,
  }) : super(key: key);

  @override
  _IngredientRowState createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  String selectedIngredient = '';
  String selectedUnit = '';
  List<String> currentUnits = [];

  @override
  void initState() {
    super.initState();
    selectedIngredient = widget.ingredients.isNotEmpty ? widget.ingredients[0] : '';
    currentUnits = widget.listIngredientObj
        .firstWhere((ingredient) => ingredient.title == selectedIngredient)
        .units;
    selectedUnit = currentUnits.isNotEmpty ? currentUnits[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDropdown(widget.screenWidth * 0.45, widget.screenHeight * 0.06, widget.ingredients, onChanged: (String? newValue) {
            setState(() {
              selectedIngredient = newValue ?? '';
              currentUnits = widget.listIngredientObj
                  .firstWhere((ingredient) => ingredient.title == selectedIngredient)
                  .units;
              selectedUnit = currentUnits.isNotEmpty ? currentUnits[0] : '';
            });
          }),
          SizedBox(width: widget.screenWidth * 0.01),
          buildTextField(widget.screenWidth * 0.20, widget.screenHeight * 0.06, ' '),
          SizedBox(width: widget.screenWidth * 0.01),
          buildDropdown(widget.screenWidth * 0.20, widget.screenHeight * 0.06, currentUnits, onChanged: (String? newValue) {
            setState(() {
              selectedUnit = newValue ?? '';
            });
          }),
          buildRemoveIngredientButton(widget.screenWidth, widget.screenHeight),
        ],
      ),
    );
  }

  Widget buildDropdown(double width, double height, List<String> items, {required Function(String? newValue)? onChanged}) {
    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField<String>(
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(double width, double height, String hintText) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildRemoveIngredientButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.05,
      height: screenHeight * 0.026,
      child: GestureDetector(
        onTap: () {
          widget.onRemove(widget.key!);
        },
        child: const Icon(
          Icons.remove,
          color: Color(0xFFFF6E41),
        ),
      ),
    );
  }
}