import 'package:flutter/material.dart';
import 'package:xopinionx/responsive.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/home_page/components/login_button.dart';
import 'package:xopinionx/ui/screens/home_page/components/signup_button.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text('OPINIONX'),
          centerTitle: isMobile,
          actions: [
            if (!isMobile)
              TextButton(
                onPressed: () {},
                child: Text('About Us'),
              ),
            if (!isMobile)
              TextButton(
                onPressed: () {},
                child: Text('Donate'),
              ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Got some doubts ?",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Want a genuine opinion ?",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Ask your doubts now",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: kDefaultPadding * 2),
                SignUpButton(),
                SizedBox(height: kDefaultPadding * 2),
                LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
