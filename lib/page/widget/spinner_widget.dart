import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerWidget extends StatefulWidget {
  bool show = false;
  SpinnerWidget(bool show, {Key? key}) {
    this.show = show;
  }

  @override
  _SpinnerWidgetState createState() {
    return _SpinnerWidgetState();
  }

}

class _SpinnerWidgetState extends State<SpinnerWidget> {

  @override
  Widget build(BuildContext context) {
    if(!widget.show) return Container();
    return Align(
        alignment: Alignment(0, -0.2),
        child: Container(
          width: 50,
          height: 50,
          child: SpinKitCircle(
            //You can find other examples here.
            //https://github.com/jogboms/flutter_spinkit/blob/master/example/lib/showcase.dart
              color: Color(0xff00ffe0)
          ),
        )
    );
  }
}