import 'package:flutter/material.dart';

class Category {
  final String catId;
  final String catTitle;
  final Color catColor;

  const Category({
    @required this.catId,
    @required this.catTitle,
    this.catColor = Colors.amber,
  });
}
