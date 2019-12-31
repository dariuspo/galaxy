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

  AnimationController cornerPlanetController;
  AnimationController spiralPlanetController;

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
      end: Offset(8.0, 8.0),
    ).animate(
      CurvedAnimation(
        parent: spiralPlanetController,
        curve: Curves.linear,
      ),
    );
    cornerPlanetController = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
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
    spiralPlanetController.repeat();
    cornerPlanetController.repeat();
  }

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
          child: Stack(
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
                radius: 160,
                animationMovement: spiralPlanetAnimation,
                child: ShapeBuilder(
                  color: Colors.lightBlue,
                  radius: 20,
                  boxShape: BoxShape.rectangle,
                ),
              ),
              MovementAnimationBuilder(
                radius: 220,
                animationMovement: spiralPlanetAnimation,
                child: ShapeBuilder(
                  color: Colors.deepOrange,
                  radius: 40,
                  boxShape: BoxShape.circle,
                ),
              ),
              MovementAnimationBuilder(
                radius: 300,
                animationMovement: spiralPlanetAnimation,
                child: TriangleBuilder(radius: 20,color: Colors.redAccent,)
              ),
              MovementAnimationBuilder(
                radius: 400,
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
                    (screenWidth / (-2) - 100) * cornerPlanetAnimation.value.dx,
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
                    (screenWidth / 2 + 100) * cornerPlanetAnimation.value.dx,
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
                    (screenWidth / (-2) - 100) * cornerPlanetAnimation.value.dx,
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
                    (screenWidth / (-2) - 100) * cornerPlanetAnimation.value.dx,
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
          ),
        ),
      ),
    );
  }
}
