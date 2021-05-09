import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        child: Text(
          'Login',
          style: TextStyle(
            letterSpacing: 1.3,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 1.5,
          horizontal: kDefaultPadding * 6,
        ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Colors.green),
        ),
      ),
      onPressed: () {
        BlocProvider.of<HomePageBloc>(context).add(LoginPageRequested());
      },
    );
  }
}
