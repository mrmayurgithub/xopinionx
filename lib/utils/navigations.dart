import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

// void mainNavigations(BuildContext context, String route, {bool pushReplacementNamed = false}) {
//   if (!pushReplacementNamed) {
//     context.vxNav.push(Uri.parse(route));
//   } else
//     context.vxNav.clearAndPush(Uri.parse(route));
// }

void nNavigator(BuildContext context, String route) {
  context.vxNav.push(Uri.parse(route));
}

void pNavigator(BuildContext context, String route) {
  context.vxNav.clearAndPush(Uri.parse(route));
}
