import 'package:flutter/material.dart';
import 'package:recipes/features/statistics/widgets/satatistic_field.dart';

class Stat extends StatelessWidget {
  final List<String> categories;
  final List<String> answers;
  final double width;
  final double height;

  const Stat(
      {super.key,
        required this.categories,
        required this.answers,
        required this.width,
        required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(categories.length, (index) {
        return Column(children: [
          StatisticField(
            text: categories[index],
            answer: answers[index],
            width: width,
          ),
          SizedBox(height: height * 0.28)
        ]);
      }),
    );
  }
}
