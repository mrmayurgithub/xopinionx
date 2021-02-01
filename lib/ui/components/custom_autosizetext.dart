import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomAutoSizeText extends StatelessWidget {
  final width;
  final String title;
  final fontSize;
  final int maxLines;

  const CustomAutoSizeText({@required this.width, @required this.title, @required this.fontSize, @required this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: AutoSizeText(
        title,
        maxLines: maxLines,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
