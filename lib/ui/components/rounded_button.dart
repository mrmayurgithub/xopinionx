import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  const RoundedButton({this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}
