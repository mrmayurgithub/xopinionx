import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xopinionx/ui/components/home_navigation_bar.dart/navigation_bar_desktop.dart';
import 'package:xopinionx/ui/components/home_navigation_bar.dart/navigation_bar_mobile.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(),
      desktop: NavigationBarDesktop(),
    );
  }
}
