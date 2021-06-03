import 'package:flutter/material.dart';
import 'package:xopinionx/ui/global/utils.dart';

class NavigationBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ,
      constraints: BoxConstraints(maxHeight: screenHeight / 2),
      child: const Drawer(),
    );
  }
}
