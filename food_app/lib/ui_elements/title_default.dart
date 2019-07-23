import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;

  TitleDefault(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
