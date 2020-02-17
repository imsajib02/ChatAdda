import 'package:flutter/material.dart';

class ButtonAnimation extends StatefulWidget {
  @override
  _AnimationState createState() => _AnimationState();
}

class _AnimationState extends State<ButtonAnimation> with TickerProviderStateMixin {

  AnimationController _animationController;
  AnimationController _fadeAnimationController;
  AnimationController _scaleAnimationController;

  Animation<double> _animation;
  Animation<double> _fadeAnimation;
  Animation<double> _scaleAnimation;

  double scale = 1.0;
  bool animationComplete = false;
  bool animationStart = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 130),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController)
      ..addStatusListener((status) {});

    _fadeAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(_fadeAnimationController);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8, //tap down ratio
    ).animate(_scaleAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleAnimationController.reverse();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _scaleAnimationController,
          builder: (context, child) => Transform.scale(

            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: () {
              _scaleAnimationController.forward();
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(child: Text('Button')),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
