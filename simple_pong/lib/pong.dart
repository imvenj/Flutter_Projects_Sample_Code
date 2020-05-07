import 'package:flutter/material.dart';
import 'package:simple_pong/bat.dart';
import 'package:simple_pong/ball.dart';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width;
  double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  Animation<double> animation;
  AnimationController controler;

  double increment = 5;

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width - 50 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height - 50 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controler = AnimationController(
      duration: Duration(minutes: 10000),
      vsync: this
    );
    animation = Tween<double>(
      begin: 0,
      end: 0
    ).animate(controler);
    animation.addListener(() {
      setState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controler.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      batWidth = width / 5;
      batHeight = height / 20;
      return Stack(
        children: <Widget>[
          Positioned(
            child: Ball(),
            top: posY,
            left: posX
          ),
          Positioned(
            child: Bat(batWidth, batHeight),
            bottom: 0
          )
        ],
      );
    });
  }
}
