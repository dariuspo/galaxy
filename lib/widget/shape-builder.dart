import 'package:flutter/material.dart';
class ShapeBuilder extends StatelessWidget {
  final double radius;
  final Color color;
  final BoxShape boxShape;
  ShapeBuilder({this.radius, this.color, this.boxShape});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: boxShape),
      ),
    );
  }
}
