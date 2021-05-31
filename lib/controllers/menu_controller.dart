// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/state_manager.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class MenuController extends GetxController {
//   RxInt _selectedIndex = 0.obs;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int get selectedIndex => _selectedIndex.value;

//   List<MainMenuItem> get menuItems => [
//         MainMenuItem(
//           title: "Home",
//           icon: CupertinoIcons.home,
//         ),
//         MainMenuItem(
//           title: "Chats",
//           icon: Icons.chat_outlined,
//         ),
//         MainMenuItem(
//           title: "Queries",
//           icon: CupertinoIcons.question,
//         ),
//         MainMenuItem(
//           title: "Profile",
//           icon: CupertinoIcons.person,
//         ),
//         MainMenuItem(
//           title: "History",
//           icon: Icons.history_outlined,
//         ),
//         MainMenuItem(
//           title: "Blog",
//           icon: FontAwesomeIcons.blog,
//         ),
//         MainMenuItem(
//           title: "Logout",
//           icon: Icons.logout_outlined,
//         ),
//       ];
//   // ["Home", "Chats", "Your Queries", "Profile", "History", "Blog", "Logout"];

//   List<IconData> get icons => [
//         FontAwesomeIcons.home,
//         FontAwesomeIcons.question,
//       ];

//   GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

//   void openOrCloseDrawer() {
//     if (_scaffoldKey.currentState.isDrawerOpen) {
//       _scaffoldKey.currentState.openEndDrawer();
//     } else {
//       _scaffoldKey.currentState.openDrawer();
//     }
//   }

//   void setMenuIndex(int index) {
//     _selectedIndex.value = index;
//   }
// }

// class MainMenuItem {
//   final String title;
//   final IconData icon;
//   final String route;
//   MainMenuItem({@required this.title, @required this.icon, this.route});
// }
