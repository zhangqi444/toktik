import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorkSpace extends StatelessWidget {
  const WorkSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      child: SpinKitCircle(
        //You can find other examples here.
        //https://github.com/jogboms/flutter_spinkit/blob/master/example/lib/showcase.dart
          color: Color(0xff00ffe0)
      ),
    );
  }
}