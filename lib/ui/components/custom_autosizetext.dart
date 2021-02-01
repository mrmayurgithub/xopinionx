import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomAutoSizeText extends StatelessWidget {
  final width;
  final String title;
  final fontSize;
  final int maxLines;
  final Color color;
  const CustomAutoSizeText({@required this.width, @required this.title, @required this.fontSize, @required this.maxLines, @required this.color});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child: AutoSizeText(
        title,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
