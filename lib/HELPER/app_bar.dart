import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget title;

  const CustomAppBar({
    Key? key,
    required this.height,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.4),
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(.9),
                spreadRadius: 2,
                offset: const Offset(2, -2)),
            BoxShadow(
                color: Colors.blue.withOpacity(.6),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(-2, 2))
          ]),
      child: AppBar(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: title,
        // centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
