import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/ui/components/list_item.dart';
import 'package:xopinionx/ui/screens/ask_query_page/ask_query_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/login_page/login_page.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/user_home_bloc.dart';

class UserHomePage extends StatelessWidget {
  static const id = 'user_home_page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeBloc(),
      child: UserHomeMainBody(),
    );
  }
}

class UserHomeMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeBloc, UserHomeState>(
      listener: (context, state) {
        if (state is UserHomeIntial) {}
        if (state is UserHomeInProgress) {}
        if (state is UserHomeSuccess) {}
        if (state is UserHomeFailure) {}
        if (state is AskQueryLoaded) {
          Navigator.of(context).pushNamed(AskQueryPage.id);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text('Opinionx'),
            actions: [
              FlatButton(
                onPressed: () {},
                child: Text('Blog'),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('Donate'),
              ),
            ],
          ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<UserHomeBloc>(context).add(
                        UserHomeAskQueryRequested(),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Ask my Query'),
                    ),
                    color: Colors.blue,
                  ),
                  SizedBox(height: 100),
                  ListTile(
                    title: Center(
                      child: Text('Answer Some Queries'),
                    ),
                    subtitle: Center(
                      child: Text('Help your juniors'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
