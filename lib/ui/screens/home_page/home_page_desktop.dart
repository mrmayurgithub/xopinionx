import 'package:flutter/material.dart';
import 'package:xopinionx/config/responsive.dart';
import 'package:xopinionx/ui/components/bottom_bar.dart';
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
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          // backgroundColor: Color(0xff212121),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 4.0,
            backgroundColor: kSecondaryColor,
            title: const Text('Opinionx'),
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
                      'Blog',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              if (!isMobile)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'About Us',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              if (!isMobile)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => Scrollbar(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.infinity,
                          height: constraints.maxHeight,
                          color: kSecondaryColor,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  "Got some doubts ?\nWant a genuine opinion ?\nClear your doubts now !",
                                  style: TextStyle(
                                    fontSize: isMobile ? 24 : 36,
                                    // color: Color(0xff212121),
                                    color: kTextColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: kDefaultPadding * 3),
                                Flex(
                                  direction: isMobile
                                      ? Axis.vertical
                                      : Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SignUpButton(),
                                    if (isMobile)
                                      const SizedBox(height: kDefaultPadding)
                                    else
                                      const SizedBox(width: kDefaultPadding),
                                    LoginButton(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        BottomBar(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
