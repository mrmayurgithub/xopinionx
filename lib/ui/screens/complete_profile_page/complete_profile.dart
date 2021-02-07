import 'package:flutter/material.dart';

class ProfileRegPage extends StatelessWidget {
  static const String id = "profile_reg_page";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CompleteProfilePage extends StatefulWidget {
  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  static const id = "complete_profile_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class completeProfileMainPage extends StatefulWidget {
  @override
  _completeProfileMainPageState createState() => _completeProfileMainPageState();
}

class _completeProfileMainPageState extends State<completeProfileMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
