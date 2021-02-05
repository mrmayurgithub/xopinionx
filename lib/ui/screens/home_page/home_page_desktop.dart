import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/ui/components/custom_autosizetext.dart';
import 'package:xopinionx/ui/components/rounded_button.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              color: Color.fromARGB(255, 118, 222, 140),
              width: screenWidth / 2,
              height: screenHeight,
              child: Column(
                children: [],
              ),
            ),
            Container(
              width: screenWidth / 2,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAutoSizeText(
                    width: screenWidth / 5,
                    title: "Got some doubts ?",
                    fontSize: 30,
                    maxLines: 3,
                    color: Colors.black,
                  ),
                  CustomAutoSizeText(
                    width: screenWidth / 5,
                    title: " Want a genuine  opinion ?",
                    fontSize: 30,
                    maxLines: 3,
                    color: Colors.black,
                  ),
                  CustomAutoSizeText(
                    width: screenWidth / 5,
                    title: "Ask your doubts now",
                    fontSize: 30,
                    maxLines: 3,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SignUpButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends StatefulWidget {
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.green,
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 120,
        ),
        child: Text(
          'SignUp',
          style: TextStyle(
            letterSpacing: 1.3,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
