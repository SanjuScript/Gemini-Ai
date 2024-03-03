import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  final void Function() buttontapped;
  final int index;
  final String buttonText;
  final Color color;
  const StyledContainer(
      {super.key,
      required this.buttontapped,
      required this.buttonText,
      this.index = 0,
      this.color = const Color(0xff49A2F1)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: Container(
          decoration: BoxDecoration(
              color: color.withOpacity(.9),
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color:color.withOpacity(.9),
                    spreadRadius: 2,
                    offset: const Offset(2, -2)),
                BoxShadow(
                    color: color,
                    blurRadius: 8,
                    offset: const Offset(-2, 2))
              ]),
          child: Center(
            child: Text(
             buttonText,
              style:  TextStyle(
                color: Theme.of(context).cardColor,
                // fontFamily: FontName.font2,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
