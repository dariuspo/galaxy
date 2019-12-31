import 'package:flutter/material.dart';
import 'package:galaxy/painter/triangle-painter.dart';
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

class _GalaxyState extends State<Galaxy> with SingleTickerProviderStateMixin {
  Animation<Offset> cornerPlanetAnimation;
  AnimationController cornerPlanetController;

  @override
  void initState() {
    super.initState();

    // TODO: implement initState
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
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
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
              Transform.translate(
                offset: Offset(-80, 0.0),
                child: ShapeBuilder(
                  radius: 10,
                  color: Colors.grey,
                  boxShape: BoxShape.rectangle,
                ),
              ),
              Transform.translate(
                offset: Offset(-120.0, 0.0),
                child: TriangleBuilder(
                  color: Colors.orangeAccent,
                  radius: 20,
                ),
              ),
              Transform.translate(
                offset: Offset(-160.0, 0.0),
                child: TriangleBuilder(
                  color: Colors.blueAccent,
                  radius: 30,
                ),
              ),
              Transform.translate(
                offset: Offset(-200.0, 0.0),
                child: TriangleBuilder(
                  color: Colors.deepOrange,
                  radius: 20,
                ),
              ),
              Transform.translate(
                offset: Offset(-300.0, 0.0),
                child: ShapeBuilder(
                  color: Colors.brown,
                  radius: 50,
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
                  child: ShapeBuilder(
                    color: Colors.red,
                    radius: 20,
                    boxShape: BoxShape.rectangle,
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
