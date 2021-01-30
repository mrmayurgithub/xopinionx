import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:xopinionx/ui/global/utils.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  Color _color1 = Color.fromARGB(255, 9, 220, 129);
  Color _color2 = Color.fromARGB(255, 255, 107, 74);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: Icon(
          Icons.connect_without_contact_outlined,
          color: Colors.black,
        ),
        backgroundColor: _color1,
        title: Text(
          'OPINIONX',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Open Sans',
          ),
        ),
        actions: [
          FlatButton(
            child: Text('HOME'),
            onPressed: () {},
          ),
          FlatButton(
            child: Text('BLOG'),
            onPressed: () {},
          ),
          FlatButton(
            child: Text('DONATE'),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 600,
                color: _color1,
              ),
            ),
            Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/images/home_page_images/1.png',
                    width: screenWidth / 2,
                    height: screenHeight / 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: _color2,
                    height: 300,
                    width: 300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
