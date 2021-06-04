import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/api/functions/problem_functions.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/global/tags_map.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/user_queries/bloc/user_queries_bloc.dart';

class UserQueries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserQueriesBloc(),
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
        if (state is ProblemChatLoaded) {
          Navigator.of(context).pop();
        }
        if (state is ProblemDeleted) {
          //TODO: this is not working
          Navigator.of(context).pop();
        }
        if (state is ProblemEdited) {}
        if (state is ProblemSolved) {}
        if (state is UserQueriesFailure) {}
        if (state is UserQueriesLoaded) {
          logger.d('UserQueriesLoaded');
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return StreamProvider<List<ProblemModel>>.value(
          value: ProblemFunctions().userQueries,
          child: Scaffold(
            appBar: AppBar(),
            drawer: MainDrawer(),
            body: UserQueryList(
              userQueriesBloc: UserQueriesBloc(),
            ),
          ),
        );
      },
    );
  }
}

class UserQueryList extends StatefulWidget {
  final UserQueriesBloc userQueriesBloc;

  const UserQueryList({Key key, this.userQueriesBloc}) : super(key: key);

  @override
  _UserQueryListState createState() => _UserQueryListState();
}

class _UserQueryListState extends State<UserQueryList> {
  @override
  Widget build(BuildContext context) {
    final userQueries = Provider.of<List<ProblemModel>>(context);
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: kBackgroundColor,
              child: const Padding(
                padding: EdgeInsets.only(left: 200, top: 100, bottom: 100),
                child: SelectableText(
                  'Your Queries',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            if (userQueries == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No User Queries"),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userQueries.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(userQueries[index].problemTitle),
                      subtitle: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(tagsMap[userQueries[index].tag]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const SelectableText("Are you sure ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      widget.userQueriesBloc.add(
                                        DeleteProblemRequested(
                                          problem: userQueries[index],
                                        ),
                                      );
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                      ),
                      children: [
                        SelectableText(userQueries[index].problemDescription),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text("Chat"),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:xopinionx/global/global_helpers.dart';
// import 'package:xopinionx/global/logger.dart';
// import 'package:xopinionx/global/tags_map.dart';
// import 'package:xopinionx/ui/components/drawer.dart';
// import 'package:xopinionx/ui/components/showProgress.dart';
// import 'package:xopinionx/ui/global/constants.dart';
// import 'package:xopinionx/ui/screens/user_queries/bloc/user_queries_bloc.dart';

// class UserQueries extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserQueriesBloc()..add(UserQueriesRequested()),
//       child: UserQueriesMainBody(),
//     );
//   }
// }

// class UserQueriesMainBody extends StatefulWidget {
//   @override
//   _UserQueriesMainBodyState createState() => _UserQueriesMainBodyState();
// }

// class _UserQueriesMainBodyState extends State<UserQueriesMainBody> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserQueriesBloc, UserQueriesState>(
//       listener: (context, state) {
//         if (state is UserQueriesInProgress) {
//           showProgress(context);
//         }
//         // if (state is UserQueriesSuccess) {}
//         if (state is ProblemChatLoaded) {
//           Navigator.of(context).pop();
//         }
//         if (state is ProblemDeleted) {}
//         if (state is ProblemEdited) {}
//         if (state is ProblemSolved) {}
//         if (state is UserQueriesFailure) {}
//         if (state is UserQueriesLoaded) {
//           logger.d('UserQueriesLoaded');
//           Navigator.of(context).pop();
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//               // leading: IconButton(
//               //   icon: Icon(Icons.arrow_back),
//               //   onPressed: () {
//               //     Navigator.of(context).pop();
//               //   },
//               // ),
//               ),
//           drawer: MainDrawer(),
//           body: Scrollbar(
//             child: SingleChildScrollView(
//               physics: ClampingScrollPhysics(),
//               child: ListView(
//                 shrinkWrap: true,
//                 children: [
//                   Card(
//                     color: kBackgroundColor,
//                     // color: Colors.blueGrey[900],
//                     child: Padding(
//                       padding:
//                           EdgeInsets.only(left: 200, top: 100, bottom: 100),
//                       child: SelectableText(
//                         'Your Queries',
//                         style: TextStyle(fontSize: 40),
//                       ),
//                     ),
//                   ),
//                   for (var ele in userProblemsList)
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Container(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ExpansionTile(
//                               // leading: ,
//                               title: Text(ele.problemTitle.toString()),
//                               children: [
//                                 Text(ele.problemDescription),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {},
//                                       child: Text("View Chats"),
//                                       style: TextButton.styleFrom(),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                               subtitle: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () {},
//                                     child: Padding(
//                                       padding: EdgeInsets.all(4.0),
//                                       child: Text(tagsMap[ele.tag]),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               trailing: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.delete_outline,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
