import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text((globalUser.fname + globalUser.lname) != null
                  ? globalUser.fname + globalUser.lname
                  : ""),
              leading: const CircleAvatar(
                child: Icon(Icons.face_outlined),
              ),
              subtitle: Text((globalUser.email.toString()) != null
                  ? globalUser.email.toString()
                  : ""),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Home Page'),
              leading: const Icon(Icons.home),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.userHomeRoute);
                logger.i("User Home Pressed");
                // nNavigator(context, MainRoutes.userHomeRoute);
                context.vxNav.clearAndPush(Uri.parse(MainRoutes.userHomeRoute));
              },
            ),
            ListTile(
              title: const Text('Chats'),
              leading: const Icon(Icons.meeting_room_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.chatRoute);
                // nNavigator(context, MainRoutes.chatRoute);
                context.vxNav.push(Uri.parse(MainRoutes.chatRoute));
              },
            ),
            ListTile(
              title: const Text('Your Queries'),
              leading: const Icon(Icons.question_answer_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.userQueries);
                // nNavigator(context, MainRoutes.userQueries);
                context.vxNav.push(Uri.parse(MainRoutes.userQueries));
              },
            ),
            ListTile(
              title: const Text('Overall Review'),
              leading: const Icon(Icons.rate_review_outlined),
              subtitle: const Text('⭐⭐⭐⭐'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Session Balance'),
              leading: const Icon(Icons.account_balance_outlined),
              subtitle: Text(globalUser.sessionBalance.toString()),
              onTap: () {},
            ),
            ListTile(
              title: const Text('History'),
              leading: const Icon(Icons.history_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.historyRoute);
                // nNavigator(context, MainRoutes.historyRoute);
                context.vxNav.push(Uri.parse(MainRoutes.historyRoute));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.settingsRoute);
                // nNavigator(context, MainRoutes.settingsRoute);
                context.vxNav.push(Uri.parse(MainRoutes.settingsRoute));
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.login_outlined),
              onTap: () async {
                BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());
                //TODO: change this to streams instead
                // Navigator.of(context).pushReplacementNamed(MainRoutes.homePageRoute);
                // pNavigator(context, MainRoutes.homePageRoute);
                context.vxNav.clearAndPush(Uri.parse(MainRoutes.homePageRoute));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.colorize),
            //   title: Theme.of(context).brightness == Brightness.dark ? Text("Dark Theme") : Text("Light Theme"),
            //   onTap: () {
            //     if (Theme.of(context).brightness == Brightness.light) {
            //       BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Dark));
            //     } else {
            //       BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Light));
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
