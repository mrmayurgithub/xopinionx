import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/global/tags_map.dart';
import 'package:xopinionx/responsive.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/user_home_bloc.dart';
import 'package:xopinionx/ui/screens/user_home_page/components/report_content.dart';
import 'package:xopinionx/ui/screens/user_home_page/components/web_menu.dart';
import 'package:xopinionx/utils/navigations.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

// class UserHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserHomeBloc(),
//       child: UserHomeMainBody(),
//     );
//   }
// }

// class UserHomeMainBody extends StatelessWidget {
//   List<ProblemModel> _problems = globalProblemsList;
//   bool positionTheme = true;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserHomeBloc, UserHomeState>(
//       listener: (context, state) {
//         if (state is UserHomeIntial) {}
//         if (state is UserHomeInProgress) {
//           showProgress(context);
//         }
//         if (state is QueryNotAllowed) {
//           Fluttertoast.showToast(
//               msg: 'You cannot ask more than 3 Queries at a time');
//         }
//         if (state is UserHomeSuccess) {}
//         if (state is UserHomeFailure) {
//           // Navigator.of(context).pop();
//           context.vxNav.pop();
//           Fluttertoast.showToast(msg: state.message);
//           logger.wtf(state.message);
//         }
//         if (state is AskQueryLoaded) {
//           // Navigator.of(context).pushNamed(MainRoutes.askQueryRoute);
//           nNavigator(context, MainRoutes.askQueryRoute);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             automaticallyImplyLeading: false,
//             elevation: 0.0,
//             centerTitle: true,
//             title: Container(
//               width: double.infinity,
//               color: Theme.of(context).scaffoldBackgroundColor,
//               child: Column(
//                 children: [
//                   Container(
//                     constraints: BoxConstraints(maxWidth: kMaxWidth),
//                     padding: EdgeInsets.all(kDefaultPadding),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             if (!Responsive.isDesktop(context))
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.menu,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: () {},
//                               ),
//                             Text("OPINIONX"),
//                             Spacer(),
//                             WebMenu(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // actions: [
//             //   Padding(
//             //     padding: EdgeInsets.symmetric(
//             //       vertical: kDefaultPadding / 5,
//             //       horizontal: kDefaultPadding / 5,
//             //     ),
//             //     child: TextButton(
//             //       onPressed: () {
//             //         BlocProvider.of<UserHomeBloc>(context)
//             //             .add(UserHomeAskQueryRequested());
//             //       },
//             //       child: Text(
//             //         'Ask Query',
//             //         style: TextStyle(
//             //           color: Colors.blue,
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ],
//           ),
//           drawerScrimColor: Colors.transparent,
//           // drawer: MainDrawer(),
//           body: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Divider(),
//                 ListTile(
//                   title: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Center(
//                       child: SelectableText('Answer Some Queries'),
//                     ),
//                   ),
//                   subtitle: Center(
//                     child: SelectableText('Help your juniors'),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 _problems.length != 0
//                     ? CupertinoScrollbar(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           child: ListView(
//                             shrinkWrap: true,
//                             children: [
//                               for (ProblemModel ele in _problems)
//                                 ExpansionTile(
//                                   title: Text(ele.problemTitle),
//                                   children: [
//                                     AutoSizeText(ele.problemDescription),
//                                     SizedBox(height: 10),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         TextButton(
//                                           onPressed: () {},
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 8.0),
//                                             child: Text(tagsMap[ele.tag]),
//                                           ),
//                                           style: TextButton.styleFrom(
//                                               backgroundColor:
//                                                   Colors.grey[800]),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             //TODO: implement
//                                             // Navigator.of(context).pushNamed(ChatPage.id);
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 8.0),
//                                             child: Text('Chat'),
//                                           ),
//                                           style: TextButton.styleFrom(
//                                               backgroundColor:
//                                                   Colors.grey[800]),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                   trailing: IconButton(
//                                     icon: Icon(Icons.info_outline),
//                                     onPressed: () {
//                                       return showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return ReportContent();
//                                         },
//                                       );
//                                     },
//                                   ),
//                                   childrenPadding: EdgeInsets.all(10),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : SelectableText('No Queries to show'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

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
  final List<ProblemModel> _problems = globalProblemsList;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeBloc, UserHomeState>(
      listener: (context, state) {
        if (state is UserHomeIntial) {}
        if (state is UserHomeInProgress) {
          showProgress(context);
        }
        if (state is QueryNotAllowed) {
          Fluttertoast.showToast(
              msg: 'You cannot ask more than 3 Queries at a time');
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            centerTitle: true,
            title: Container(
              width: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: kMaxWidth),
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (!Responsive.isDesktop(context))
                              IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            Text("OPINIONX"),
                            Spacer(),
                            Container(
                              color: Colors.transparent,
                              child: PopupMenuButton(
                                elevation: 0.0,
                                offset: Offset(1, 1),
                                icon: Icon(Icons.person),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text("Profile Settings"),
                                        trailing: Icon(Icons.settings),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text("Overall Review"),
                                        subtitle: Text('⭐⭐⭐⭐'),
                                        trailing:
                                            Icon(Icons.rate_review_outlined),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text("Session Balance"),
                                        trailing: Icon(
                                            Icons.account_balance_outlined),
                                        subtitle: Text(globalUser.sessionBalance
                                            .toString()),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text("History"),
                                        trailing: Icon(Icons.history_outlined),
                                      ),
                                    ),
                                  ];
                                },
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
          drawerScrimColor: Colors.transparent,
          // drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  constraints: BoxConstraints(maxWidth: kMaxWidth),
                  child: SafeArea(child: HomeMainList()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeMainList extends StatefulWidget {
  @override
  _HomeMainListState createState() => _HomeMainListState();
}

class _HomeMainListState extends State<HomeMainList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) Expanded(child: WebMenu()),
        if (!Responsive.isMobile(context)) SizedBox(width: kDefaultPadding),
        QueryList(),
      ],
    );
  }
}

class QueryList extends StatelessWidget {
  final List<ProblemModel> _problems = globalProblemsList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All Questions",
                style: TextStyle(fontSize: 15),
              ),
              Spacer(),
              TextButton(
                child: Container(
                  child: Text(
                    "Ask Question",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2.5,
                    vertical: kDefaultPadding / 5,
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<UserHomeBloc>(context)
                      .add(UserHomeAskQueryRequested());
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey[600],
          ),
          SizedBox(height: kDefaultPadding),
          _problems.length != 0
              ? Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (ProblemModel ele in _problems)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {},
                                title: Text(
                                  ele.problemTitle.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      ele.problemDescription,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(ele.tag.toString()),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              : SelectableText("No Questions to show"),
        ],
      ),
    );
  }
}
