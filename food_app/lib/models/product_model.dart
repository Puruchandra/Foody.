import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  final bool isFavorite;
  final String email;
  final String userId;

  ProductModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imgUrl,
    this.isFavorite = false,
    @required this.email,
    @required this.userId
  });
}
