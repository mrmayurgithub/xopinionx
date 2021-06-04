import 'package:flutter/material.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpButton extends StatefulWidget {
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.vxNav.push(Uri.parse(MainRoutes.registerRoute));
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding * 2),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 1.5,
          horizontal: kDefaultPadding * 6,
        ),
        child: const Text(
          'SignUp',
          style: TextStyle(
            letterSpacing: 1.3,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
