import 'package:flutter/material.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 80,
          color: Color.fromARGB(255, 255, 107, 74),
          child: Row(
            children: [Text('dhdhdh')],
          ),
        ),
        preferredSize: Size.fromHeight(80),
      ),
      body: ListView(),
    );
  }
}
