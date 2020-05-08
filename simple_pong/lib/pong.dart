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
  AnimationController controller;

  double increment = 5;

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() => function());
    }
  }

  void checkBorders() {
    if (width == null) { return; } // Prevent NoSuchMethodError.
    double diameter = 50;
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      if (posX >= batPosition - diameter && posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
      }
      else {
        controller.stop();
        dispose();
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: Duration(minutes: 10000),
      vsync: this
    );
    animation = Tween<double>(
      begin: 0,
      end: 100
    ).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            bottom: 0,
            left: batPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails update) => moveBat(update),
              child: Bat(batWidth, batHeight),
            )
          )
        ],
      );
    });
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      // Prevent bat move out of borders.
      double destination = batPosition + update.delta.dx;
      if (destination < 0) {
        batPosition = 0;
      }
      else if (destination > width - batWidth) {
        batPosition = width - batWidth;
      }
      else {
        batPosition = destination;
      }
    });
  }
}
