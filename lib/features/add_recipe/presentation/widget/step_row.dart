import 'package:flutter/material.dart';

class StepRow extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final Function(Key) onRemove;

  const StepRow({
    required Key key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onRemove,
  }) : super(key: key);

  @override
  StepRowState createState() => StepRowState();
}

class StepRowState extends State<StepRow> {
  String step = '';

  String getCurrentState() {
    return step;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.screenWidth * 0.9,
          height: widget.screenHeight * 0.06,
          child: Row(
            children: [
              SizedBox(
                width: widget.screenWidth * 0.8,
                height: widget.screenHeight * 0.06,
                child: TextFormField(
                  onChanged: (String? newValue) {
                    setState(() {
                      step = newValue ?? '';
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: widget.screenWidth * 0.024),
              buildRemoveStepButton(widget.screenWidth, widget.screenHeight),
            ],
          ),
        ),
        SizedBox(height: widget.screenHeight * 0.011),
      ],
    );
  }

  Widget buildRemoveStepButton(double screenWidth, double screenHeight) {
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