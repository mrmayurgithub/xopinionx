import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:xopinionx/ui/global/utils.dart';

class HomePage extends StatelessWidget {
  static const String id = "home_page";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Opinionx',
            style: TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w700),
          ),
          //9,220,129
          // backgroundColor: Color.fromARGB(255, 9, 220, 129),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(),
          // child: Stack(
          //   children: <Widget>[
          //     ClipPath(
          //       child: Container(
          //         color: Colors.lightGreen[300],
          //         height: 140,
          //         width: screenWidth,
          //       ),
          //       clipper: WaveClipperOne(),
          //     ),
          //     ClipPath(
          //       child: Container(
          //         color: Colors.lightGreen[400],
          //         height: 120,
          //         width: screenWidth,
          //       ),
          //       clipper: WaveClipperTwo(),
          //     ),
          //     Positioned(
          //       left: 60,
          //       top: 20,
          //       child: Text(
          //         'OpinionX',
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //           color: Colors.black,
          //           fontSize: 30,
          //           fontFamily: 'Open Sans',
          //           letterSpacing: 0.2,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
