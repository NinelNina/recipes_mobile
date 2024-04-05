import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackNavWidget extends StatelessWidget {
  const BackNavWidget({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.15,
      child: SvgPicture.asset('assets/images/back_vector.svg',
          width: 10, height: 18),
    );
  }

}