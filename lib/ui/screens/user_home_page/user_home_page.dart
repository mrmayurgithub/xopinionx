import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/theme/app_themes.dart';
import 'package:xopinionx/ui/global/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/ui/screens/ask_query_page/ask_query_page.dart';
import 'package:xopinionx/ui/screens/chats_page/chats_screen.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/settings_page/settings_page.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/user_home_bloc.dart';
import 'package:xopinionx/ui/screens/user_queries/user_queries.dart';

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
              // TextButton(
              //   onPressed: () {},
              //   child: Text('Blog'),
              // ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text('Donate'),
              // ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<UserHomeBloc>(context).add(
                      UserHomeAskQueryRequested(),
                    );
                    // return showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Padding(
                    //       padding: EdgeInsets.all(8.0),
                    //       child: AlertDialog(
                    //         content: QueryForm(),
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  child: Text('Ask Query'),
                ),
              ),
            ],
          ),
          drawerScrimColor: Colors.transparent,
          drawer: MainDrawer(),
          body: RefreshIndicator(
            onRefresh: () async {
              await loadGlobalProblems();
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                        ? Scrollbar(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                for (ProblemModel ele in _problems)
                                  ExpansionTile(
                                    title: Text(ele.problemTitle),
                                    children: [
                                      AutoSizeText(ele.problemDescription),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(ele.tag.toString()),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(ChatPage.id);
                                            },
                                            child: Text('Chat'),
                                          ),
                                        ],
                                      ),
                                    ],
                                    trailing: IconButton(
                                      icon: Icon(Icons.report_outlined),
                                      onPressed: () {},
                                    ),
                                    childrenPadding: EdgeInsets.all(10),
                                  ),
                              ],
                            ),
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
