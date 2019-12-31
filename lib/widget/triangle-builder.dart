import 'package:flutter/material.dart';
import '../painter/triangle-painter.dart';
class TriangleBuilder extends StatelessWidget {
  final double radius;
  final Color color;
  TriangleBuilder({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: CustomPaint(
        painter: TrianglePainter(
            strokeColor: color,
            paintingStyle: PaintingStyle.fill,
            strokeWidth: 2
        ),
        child:Container(
          height: radius,
          width: radius,
        ),
      ),
    );
  }
}
