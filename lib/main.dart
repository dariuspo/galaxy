import 'package:flutter/material.dart';
import './widget/circle-shape.dart';

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

class _GalaxyState extends State<Galaxy> {
  @override
  Widget build(BuildContext context) {
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
                offset: Offset(0.0, 0.0),
                child: CircleShape(
                  radius: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
