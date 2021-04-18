import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/screens/user_queries/bloc/user_queries_bloc.dart';

class UserQueries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserQueriesBloc()..add(UserQueriesRequested()),
      child: UserQueriesMainBody(),
    );
  }
}

class UserQueriesMainBody extends StatefulWidget {
  @override
  _UserQueriesMainBodyState createState() => _UserQueriesMainBodyState();
}

class _UserQueriesMainBodyState extends State<UserQueriesMainBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserQueriesBloc, UserQueriesState>(
      listener: (context, state) {
        if (state is UserQueriesInProgress) {
          showProgress(context);
        }
        // if (state is UserQueriesSuccess) {}
        if (state is ProblemChatLoaded) {}
        if (state is ProblemDeleted) {}
        if (state is ProblemEdited) {}
        if (state is ProblemSolved) {}
        if (state is UserQueriesFailure) {}
        if (state is UserQueriesLoaded) {
          logger.d('UserQueriesLoaded');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              ),
          drawer: MainDrawer(),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    // color: Colors.blueGrey[900],
                    child: Padding(
                      padding: EdgeInsets.only(left: 200, top: 100, bottom: 100),
                      child: SelectableText(
                        'Your Queries',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  for (var ele in userProblemsList)
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(ele.problemTitle.toString()),
                            subtitle: Text(ele.problemDescription),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextButton(
                                  child: Text('Chats'),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
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
