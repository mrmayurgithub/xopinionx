import 'package:flutter/material.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/utils/navigations.dart';
import 'package:xopinionx/utils/routes.dart';

class SignUpButton extends StatefulWidget {
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        child: Text(
          'SignUp',
          style: TextStyle(
            letterSpacing: 1.3,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 1.5,
          horizontal: kDefaultPadding * 6,
        ),
      ),
      onPressed: () {
        // Navigator.of(context).pushNamed(MainRoutes.registerRoute);
        nNavigator(context, MainRoutes.registerRoute);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding * 2),
        ),
      ),
    );
  }
}
