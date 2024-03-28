import 'package:chatbot_ai/COLOR/custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomPaint(
      painter: CurvePainter(),
      child: Container(
          height: size.height * .90,
          width: size.width,
         
        ),
    );
  }
}
