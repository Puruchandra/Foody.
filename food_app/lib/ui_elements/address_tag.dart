import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Text('Union Square, San Fransico'),
    );
  }
}
