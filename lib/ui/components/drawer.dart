import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/global/theme/app_themes.dart';
import 'package:xopinionx/ui/global/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/utils/navigations.dart';
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
              leading: CircleAvatar(
                child: Icon(Icons.face_outlined),
              ),
              subtitle: Text((globalUser.email.toString()) != null
                  ? globalUser.email.toString()
                  : ""),
              onTap: () {},
            ),
            ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.userHomeRoute);
                logger.i("User Home Pressed");
                nNavigator(context, MainRoutes.userHomeRoute);
              },
            ),
            ListTile(
              title: Text('Chats'),
              leading: Icon(Icons.meeting_room_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.chatRoute);
                nNavigator(context, MainRoutes.chatRoute);
              },
            ),
            ListTile(
              title: Text('Your Queries'),
              leading: Icon(Icons.question_answer_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.userQueries);
                nNavigator(context, MainRoutes.userQueries);
              },
            ),
            ListTile(
              title: Text('Overall Review'),
              leading: Icon(Icons.rate_review_outlined),
              subtitle: Text('⭐⭐⭐⭐'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Session Balance'),
              leading: Icon(Icons.account_balance_outlined),
              subtitle: Text(globalUser.sessionBalance.toString()),
              onTap: () {},
            ),
            ListTile(
              title: Text('History'),
              leading: Icon(Icons.history_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.historyRoute);
                nNavigator(context, MainRoutes.historyRoute);
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings_outlined),
              onTap: () {
                // Navigator.of(context).pushNamed(MainRoutes.settingsRoute);
                nNavigator(context, MainRoutes.settingsRoute);
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.login_outlined),
              onTap: () async {
                BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());
                //TODO: change this to streams instead
                // Navigator.of(context).pushReplacementNamed(MainRoutes.homePageRoute);
                pNavigator(context, MainRoutes.homePageRoute);
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
