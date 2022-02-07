import 'package:flutter/material.dart';

import './showcase.dart';
import './workspace.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              const Positioned.fill(child: Center(child: WorkSpace())),
            ],
          ),
        ),
      ),
    );
  }
}