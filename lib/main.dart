import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy/painter/triangle-painter.dart';
import 'package:galaxy/widget/movement-animation-builder.dart';
import 'package:galaxy/widget/triangle-builder.dart';
import './widget/shape-builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Galaxy(title: 'Galaxy App'),
    );
  }
}

class Galaxy extends StatefulWidget {
  Galaxy({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GalaxyState createState() => _GalaxyState();
}

class _GalaxyState extends State<Galaxy> with TickerProviderStateMixin {
  Animation<Offset> cornerPlanetAnimation;
  Animation<Offset> spiralPlanetAnimation;
  Animation<double> rotationAnimation;

  AnimationController cornerPlanetController;
  AnimationController spiralPlanetController;
  AnimationController rotationGalaxyController;

  static Matrix4 _pmat(num pv) {
    return new Matrix4(
      1.0,
      0.0,
      0.0,
      0.0,
      //
      0.0,
      1.0,
      0.0,
      0.0,
      //
      0.0,
      0.0,
      1.0,
      pv * 0.001,
      //
      0.0,
      0.0,
      0.0,
      1.0,
    );
  }

  @override
  void initState() {
    super.initState();

    // TODO: implement initState
    spiralPlanetController = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 6000),
        vsync: this);
    spiralPlanetAnimation = Tween(
      begin: Offset(0.0, 0.0),
      end: Offset(10.0, 10.0),
    ).animate(
      CurvedAnimation(
        parent: spiralPlanetController,
        curve: Curves.linear,
      ),
    );

    cornerPlanetController = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 6000),
        vsync: this);
    cornerPlanetAnimation = Tween(
      begin: Offset(1.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: cornerPlanetController,
        curve: Curves.easeInCubic,
      ),
    );

    rotationGalaxyController = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 6000),
        vsync: this);
    rotationAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: rotationGalaxyController,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    rotationGalaxyController.repeat();
    spiralPlanetController.repeat();
    cornerPlanetController.repeat();
  }

  Matrix4 perspective = _pmat(1.0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/empty-galaxy.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: AnimatedBuilder(
            animation: rotationAnimation,
            builder: (context, child) => Transform(
              alignment: FractionalOffset.center,
              transform: perspective.scaled(1.0, 1.0, 1.0)
                ..rotateX(pi - (rotationAnimation.value * 360) * pi / 180)
                ..rotateY(0.0)
                ..rotateZ(0.0),
              child:
                  /*RotationTransition(
                turns:rotationAnimation,
                child: */
                  Stack(
                children: <Widget>[
                  MovementAnimationBuilder(
                    radius: 100,
                    animationMovement: spiralPlanetAnimation,
                    child: ShapeBuilder(
                      color: Colors.grey,
                      radius: 30,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                  MovementAnimationBuilder(
                    radius: 125,
                    animationMovement: spiralPlanetAnimation,
                    child: ShapeBuilder(
                      color: Colors.lightBlue,
                      radius: 20,
                      boxShape: BoxShape.rectangle,
                    ),
                  ),
                  MovementAnimationBuilder(
                    radius: 166.67,
                    animationMovement: spiralPlanetAnimation,
                    child: ShapeBuilder(
                      color: Colors.deepOrange,
                      radius: 40,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                  MovementAnimationBuilder(
                      radius: 250,
                      animationMovement: spiralPlanetAnimation,
                      child: TriangleBuilder(
                        radius: 20,
                        color: Colors.redAccent,
                      )),
                  MovementAnimationBuilder(
                    radius: 500,
                    animationMovement: spiralPlanetAnimation,
                    child: ShapeBuilder(
                      color: Colors.pink,
                      radius: 60,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: cornerPlanetAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(
                        (screenWidth / 2) * cornerPlanetAnimation.value.dx,
                        (screenHeight / (-2) - 100) *
                            cornerPlanetAnimation.value.dy,
                      ),
                      child: TriangleBuilder(
                        color: Colors.deepOrange,
                        radius: 40,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: cornerPlanetAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(
                        (screenWidth / (-2) - 100) *
                            cornerPlanetAnimation.value.dx,
                        (screenHeight / (-2)) * cornerPlanetAnimation.value.dy,
                      ),
                      child: ShapeBuilder(
                        color: Colors.white,
                        radius: 40 * cornerPlanetAnimation.value.dx,
                        boxShape: BoxShape.circle,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: cornerPlanetAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(
                        (screenWidth / 2 + 300) *
                            cornerPlanetAnimation.value.dx,
                        (screenHeight / 2) * cornerPlanetAnimation.value.dy,
                      ),
                      child: ShapeBuilder(
                        color: Colors.cyanAccent,
                        radius: 80 * cornerPlanetAnimation.value.dx,
                        boxShape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: cornerPlanetAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(
                        (screenWidth / (-2) - 200) *
                            cornerPlanetAnimation.value.dx,
                        (screenHeight / (-2)) * cornerPlanetAnimation.value.dy,
                      ),
                      child: ShapeBuilder(
                        color: Colors.white,
                        radius: 40 * cornerPlanetAnimation.value.dx,
                        boxShape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: cornerPlanetAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(
                        (screenWidth / (-2) - 200) *
                            cornerPlanetAnimation.value.dx,
                        (screenHeight / 2) * cornerPlanetAnimation.value.dy,
                      ),
                      child: ShapeBuilder(
                        color: Colors.green,
                        radius: 40 * cornerPlanetAnimation.value.dx,
                        boxShape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0.0, 0.0),
                    child: ShapeBuilder(
                      radius: 50,
                      color: Colors.black,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                ],
                /*),*/
              ),
            ),
          ),
        ),
      ),
    );
  }
}
