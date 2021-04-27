import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/global/tags_map.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/user_home_bloc.dart';
import 'package:xopinionx/utils/navigations.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class UserHomePage extends StatelessWidget {
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
          // Navigator.of(context).pop();
          context.vxNav.pop();
          Fluttertoast.showToast(msg: state.message);
          logger.wtf(state.message);
        }
        if (state is AskQueryLoaded) {
          // Navigator.of(context).pushNamed(MainRoutes.askQueryRoute);
          nNavigator(context, MainRoutes.askQueryRoute);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: SelectableText('Opinionx'),
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
                      title: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: SelectableText('Answer Some Queries'),
                        ),
                      ),
                      subtitle: Center(
                        child: SelectableText('Help your juniors'),
                      ),
                    ),
                    SizedBox(height: 10),
                    _problems.length != 0
                        ? CupertinoScrollbar(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text(tagsMap[ele.tag]),
                                              ),
                                              style: TextButton.styleFrom(backgroundColor: Colors.grey[800]),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                //TODO: implement
                                                // Navigator.of(context).pushNamed(ChatPage.id);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text('Chat'),
                                              ),
                                              style: TextButton.styleFrom(backgroundColor: Colors.grey[800]),
                                            ),
                                          ],
                                        ),
                                      ],
                                      trailing: IconButton(
                                        icon: Icon(Icons.info_outline),
                                        onPressed: () {
                                          return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ReportContent();
                                            },
                                          );
                                        },
                                      ),
                                      childrenPadding: EdgeInsets.all(10),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : SelectableText('No Queries to show'),
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

class ReportContent extends StatefulWidget {
  @override
  _ReportContentState createState() => _ReportContentState();
}

class _ReportContentState extends State<ReportContent> {
  int grVal;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RadioListTile<int>(
                value: 0,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Violent or repulsive'),
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Hateful or abusive'),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Harmful or dangerous'),
              ),
              RadioListTile<int>(
                value: 3,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Adult content'),
              ),
              RadioListTile<int>(
                value: 4,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Spam or misleading'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Report'),
        ),
      ],
    );
  }
}
