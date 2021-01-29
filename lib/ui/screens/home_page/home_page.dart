import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:xopinionx/ui/global/utils.dart';

class HomePage extends StatelessWidget {
  static const String id = "home_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                color: Colors.purple[500],
                height: 140,
                width: screenWidth,
              ),
              clipper: WaveClipperOne(),
            ),
            ClipPath(
              child: Container(
                color: Colors.purple[700],
                height: 120,
                width: screenWidth,
              ),
              clipper: WaveClipperTwo(),
            ),
            Positioned(
              left: 60,
              top: 20,
              child: Text(
                'OpinionX',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Open Sans',
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
