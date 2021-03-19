import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/global/theme/app_themes.dart';
import 'package:xopinionx/ui/global/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/settings_page/settings_page.dart';
import 'package:xopinionx/ui/screens/user_queries/user_queries.dart';

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
              title: Text(globalUser.fname + globalUser.lname),
              leading: CircleAvatar(
                child: Icon(Icons.face_outlined),
              ),
              subtitle: Text(globalUser.email.toString()),
              onTap: () {},
            ),
            ListTile(
              title: Text('Chats'),
              leading: Icon(Icons.meeting_room_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text('Your Queries'),
              leading: Icon(Icons.question_answer_outlined),
              onTap: () {
                Navigator.of(context).pushNamed(UserQueries.id);
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
                Navigator.of(context).pushNamed(HistoryPage.id);
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings_outlined),
              onTap: () {
                Navigator.of(context).pushNamed(SettingsPage.id);
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.login_outlined),
              onTap: () async {
                BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Light));
                BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());
                //TODO: change this to streams instead
                Navigator.of(context).pushReplacementNamed(HomePage.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.colorize),
              title: Theme.of(context).brightness == Brightness.dark ? Text("Dark Theme") : Text("Light Theme"),
              onTap: () {
                if (Theme.of(context).brightness == Brightness.light) {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Dark));
                } else {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Light));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
