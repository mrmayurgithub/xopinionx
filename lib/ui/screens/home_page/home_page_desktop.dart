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
    // ignore: prefer_final_locals
    bool isMobile = Responsive.isMobile(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text('OPINIONX'),
          centerTitle: isMobile,
          actions: [
            if (!isMobile)
              TextButton(
                onPressed: () {},
                child: const Text('About Us'),
              ),
            if (!isMobile)
              TextButton(
                onPressed: () {},
                child: const Text('Donate'),
              ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  "Got some doubts ?\nWant a genuine opinion ?\nAsk your doubts now",
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kDefaultPadding * 2),
                SignUpButton(),
                const SizedBox(height: kDefaultPadding * 2),
                LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
