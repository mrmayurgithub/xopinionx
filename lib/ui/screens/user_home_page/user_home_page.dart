import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/theme/app_themes.dart';
import 'package:xopinionx/ui/global/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/ui/screens/ask_query_page/ask_query_page.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/settings_page/settings_page.dart';
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
  List<ProblemModel> _problems = globalProblemsList;
  bool positionTheme = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeBloc, UserHomeState>(
      listener: (context, state) {
        if (state is UserHomeIntial) {}
        if (state is UserHomeInProgress) {
          showProgress(context);
        }
        if (state is QueryNotAllowed) {
          Fluttertoast.showToast(msg: 'You cannot ask more than 3 Queries at a time');
        }
        if (state is UserHomeSuccess) {}
        if (state is UserHomeFailure) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: state.message);
          logger.wtf(state.message);
        }
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
          drawerScrimColor: Colors.transparent,
          drawer: Drawer(
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
                      Navigator.of(context).pushReplacementNamed(HomePage.id);
                    },
                  ),
                  // SwitchListTile(
                  //   title: Text("Dark Theme"),
                  //   value: positionTheme,
                  //   onChanged: (bool pos) {
                  //     if (pos) {
                  //       BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Dark));
                  //     } else {
                  //       BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Light));
                  //     }
                  //   },
                  // ),
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
                    // trailing: LiteRollingSwitch(
                    //   value: positionTheme,
                    //   onChanged: (bool pos) {
                    //     if (pos) {
                    //       BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Dark));
                    //     } else {
                    //       BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme: AppTheme.Light));
                    //     }
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await loadGlobalProblems();
            },
            child: Center(
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
                    SizedBox(height: 10),
                    _problems.length != 0
                        ? ListView(
                            shrinkWrap: true,
                            children: [
                              for (ProblemModel ele in _problems)
                                ExpansionTile(
                                  title: Text(ele.problemTitle),
                                  children: [
                                    AutoSizeText(ele.problemDescription),
                                  ],
                                  trailing: IconButton(
                                    icon: Icon(Icons.chat),
                                    onPressed: () {},
                                  ),
                                  childrenPadding: EdgeInsets.all(10),
                                ),
                            ],
                          )
                        : Text('No Queries to show'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
