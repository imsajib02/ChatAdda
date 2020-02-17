import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {

  final Widget childWidget;

  const BounceAnimation({

    @required this.childWidget,
  });

  BounceState createState() => BounceState();
}

class BounceState extends State<BounceAnimation> with SingleTickerProviderStateMixin {

  Widget get childWidget => widget.childWidget;

  static AnimationController scaleAnimationController;

  Animation<double> _scaleAnimation;

  double scale = 1.0;
  bool animationComplete = false;
  bool animationStart = false;

  @override
  void initState() {
    super.initState();

    scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 130),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8, //tap down ratio
    ).animate(scaleAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          scaleAnimationController.reverse();
        }
      });
  }


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: scaleAnimationController,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,

        child: childWidget,
      ),
    );
  }


}