import 'package:flutter/material.dart';

class CustomPageTransitionsBuilder extends PageTransitionsBuilder {

  const CustomPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return _CustomPageTransitionsBuilder(routeAnimation: animation, child: child);
  }
}


class _CustomPageTransitionsBuilder extends StatelessWidget {
  _CustomPageTransitionsBuilder({
    Key key,
    @required Animation<double> routeAnimation, // The route's linear 0.0 - 1.0 animation.
    @required this.child,
  }) : _turnsAnimation = routeAnimation.drive(_linearToEaseOut),
        _opacityAnimation = routeAnimation.drive(_easeInTween),
        super(key: key);

  static final Animatable<double> _linearToEaseOut = CurveTween(curve: Curves.linearToEaseOut);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);


  final Animation<double> _turnsAnimation;
  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _turnsAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: child,
      ),
    );
  }
}
