import 'dart:math';

import 'package:flutter/material.dart';

class MovementAnimationBuilder extends StatefulWidget {
  final Animation<Offset> animationMovement;
  final Widget child;
  final double radius;

  MovementAnimationBuilder({this.animationMovement, this.child, this.radius});

  @override
  _MovementAnimationBuilderState createState() =>
      _MovementAnimationBuilderState();
}

class _MovementAnimationBuilderState extends State<MovementAnimationBuilder> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationMovement,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          widget.radius * cos(widget.animationMovement.value.dx * pi * 100/widget.radius),
          (widget.radius / 2) *
              sin(widget.animationMovement.value.dy * pi * 100/widget.radius),
        ),
        child: widget.child,
      ),
    );
  }
}
