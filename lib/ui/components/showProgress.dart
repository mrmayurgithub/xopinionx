import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showProgress(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      // ignore: sized_box_for_whitespace
      child: Container(
        height: 50,
        width: 50,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    ),
  );
}
