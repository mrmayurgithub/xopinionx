import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/settings_page/bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  static const id = "settings_page";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: SettingsMainBody(),
    );
  }
}

class SettingsMainBody extends StatefulWidget {
  @override
  _SettingsMainBodyState createState() => _SettingsMainBodyState();
}

class _SettingsMainBodyState extends State<SettingsMainBody> {
  bool editable = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsInitial) {}
        if (state is SettingsInProgress) {}
        if (state is SettingsSaved) {}
        if (state is SettingsFailure) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    title: Text('Mayur Agarwal'),
                    leading: CircleAvatar(
                      child: Icon(Icons.face_outlined),
                    ),
                    subtitle: Text('mr.mayurrrr@gmail.com'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Chats'),
                    leading: Icon(Icons.meeting_room_outlined),
                    onTap: () {},
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
                    subtitle: Text('2/2'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('History'),
                    leading: Icon(Icons.history_outlined),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings_outlined),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.login_outlined),
                    onTap: () async {
                      BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());
                      Navigator.of(context).pushReplacementNamed(HomePage.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
