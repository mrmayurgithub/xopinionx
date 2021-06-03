import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:xopinionx/utils/status.dart';

// void mainNavigations(BuildContext context, String route, {bool pushReplacementNamed = false}) {
//   if (!pushReplacementNamed) {
//     context.vxNav.push(Uri.parse(route));
//   } else
//     context.vxNav.clearAndPush(Uri.parse(route));
// }

void nNavigator(BuildContext context, String route) {
  // if (UserLoginStatus().isLoggedIn())
  context.vxNav.push(Uri.parse(route));
  // else
  //   context.vxNav.clearAndPush(Uri.parse(MainRoutes.homePageRoute));
}

void pNavigator(BuildContext context, String route) {
  if (UserLoginStatus().isLoggedIn()) {
    context.vxNav.clearAndPush(Uri.parse(route));
  } else {
    context.vxNav.clearAndPush(Uri.parse(MainRoutes.homePageRoute));
  }
}
