import 'package:flutter/material.dart';

class TodoColor {
  final int colorIndex;
  TodoColor({
    required this.colorIndex,
  });

  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.orange,
  ];

  Color get color => predefinedColors[colorIndex];
}
