import 'package:flutter/material.dart';
import 'package:xopinionx/config/responsive.dart';
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
          backgroundColor: Color(0xff1d2834),
          title: const Text('OpinionX'),
          centerTitle: isMobile,
          actions: [
            if (!isMobile)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 2.2,
                  vertical: kDefaultPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SelectableText(
                      "Got some doubts ?\nWant a genuine opinion ?\nAsk your doubts now !",
                      style: TextStyle(
                        fontSize: isMobile ? 26 : 40,
                        color: Color(0xff1d2834),
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
        ),
      ),
    );
  }
}
