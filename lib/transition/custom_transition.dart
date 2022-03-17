import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SlideUpTransitions extends CustomTransition {
//   @override
//   Widget buildTransition(
//       BuildContext context,
//       Curve? curve,
//       Alignment? alignment,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child
//       ) {
//     const begin = Offset(0, 1);
//     const end = Offset.zero;
//     const curve = Curves.ease;

//     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//     return SlideTransition(
//       position: animation.drive(tween),
//       child: child,
//     );
//   }
// }

class SlideUpTransitions implements CustomTransition {

  static final transitionsBuilder = (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(0, 1);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubicEmphasized;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SharedAxisTransition(
      fillColor: Colors.transparent,
      transitionType: SharedAxisTransitionType.vertical,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: SlideTransition(
          position: animation.drive(tween),
          child: child
      ),
    );
  };

  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child
      ) =>
      transitionsBuilder(context, animation, secondaryAnimation, child);
}