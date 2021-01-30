import 'package:flutter/material.dart';
import 'package:xopinionx/ui/global/utils.dart';

class CenteredView extends StatelessWidget {
  final Widget child;

  const CenteredView({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth),
        child: child,
      ),
    );
  }
}
