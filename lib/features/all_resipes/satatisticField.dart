import 'dart:math';

import 'package:flutter/material.dart';

class StatisticField extends StatelessWidget {
  final String text;
  final String answer;
  final double width;

  const StatisticField({super.key, required this.text, required this.answer, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5A5A5A).withOpacity(0.17),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final TextSpan textSpan = TextSpan(
            text: text,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          );
          final TextPainter textPainter = TextPainter(
            text: textSpan,
            maxLines: null,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(minWidth: constraints.minWidth / 2, maxWidth: constraints.maxWidth / 2); // Половина ширины родительского контейнера

          final TextSpan answerSpan = TextSpan(
            text: answer,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          );
          final TextPainter answerPainter = TextPainter(
            text: answerSpan,
            maxLines: null,
            textDirection: TextDirection.ltr,
          );
          answerPainter.layout(minWidth: constraints.minWidth / 2, maxWidth: constraints.maxWidth / 2); // Половина ширины родительского контейнера

          return Container(
            width: constraints.maxWidth, // Ширина родительского контейнера
            height: max(textPainter.size.height, answerPainter.size.height) + 8, // Высота контейнера равна максимальной высоте текстов
            child: Row(
              children: [
                Expanded(
                  child: Text(text, style: textSpan.style),
                ),
                const SizedBox(width: 100), // Расстояние между текстами
                Expanded(
                  child: Text(answer, style: answerSpan.style, textAlign: TextAlign.center), // Выравнивание текста по центру
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
