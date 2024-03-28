import 'package:flutter/material.dart';

class PositionedText extends StatelessWidget {
  const PositionedText({super.key});

   @override
  Widget build(BuildContext context) {
    // Calculate text width
    TextSpan span = TextSpan(
      text: 'POWERED BY \n GEMINI-AI',
      style: TextStyle(
        fontFamily: 'rounder',
        fontWeight: FontWeight.w300,
        letterSpacing: 1,
        fontSize: 20,
        color: Colors.grey.withOpacity(0.2),
      ),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    double textWidth = tp.width;

    // Center text horizontally
    return Positioned(
      left: (MediaQuery.of(context).size.width - textWidth) / 2,
      bottom: 10,
      child: Text(
        'POWERED BY \n GEMINI-AI',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontFamily: 'rounder',
          fontWeight: FontWeight.w300,
          letterSpacing: 1,
          fontSize: 20,
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }
}