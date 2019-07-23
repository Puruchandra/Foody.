import 'package:flutter/material.dart';


class PriceTag extends StatelessWidget {

  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
 
    return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context).accentColor),
                  padding: EdgeInsets.all(6.0),
                  margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                  child: Text(
                    '\$' + price,
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
  }



}