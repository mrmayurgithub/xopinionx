import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/chats_page/chat_provider.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/query_list.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/user_home_bloc.dart';
import 'package:xopinionx/config/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:xopinionx/utils/status.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserHomeBloc()..add(GlobalProblemsRequested()),
        child: UserHomeMainBody());
  }
}

class UserHomeMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeBloc, UserHomeState>(
      listener: (context, state) {
        if (state is UserHomeIntial) {
          showProgress(context);
        }
        if (state is UserHomeInProgress) {
          logger.wtf("UserHome Progress");
          showProgress(context);
        }
        if (state is QueryNotAllowed) {
          Fluttertoast.showToast(
              msg: 'You cannot ask more than 3 Queries at a time');
        }

        if (state is UserHomeLoaded) {
          Navigator.of(context).pop();
        }
        if (state is UserHomeChatPage) {
          logger.i("Moving to Chat Page");
          Navigator.of(context).pop();
          final _ch =
              Provider.of<ChatSelectionProvider>(context, listen: false);
          _ch.setChat(chat: state.chatModel);
          context.vxNav.push(Uri.parse(MainRoutes.chatRoute));
        }
        if (state is UserHomeFailure) {
          context.vxNav.pop();
          Fluttertoast.showToast(msg: state.message);
          logger.wtf(state.message);
        }
        if (state is AskQueryLoaded) {
          if (isLoggedIn()) {
            context.vxNav.push(Uri.parse(MainRoutes.askQueryRoute));
          } else {
            context.vxNav.clearAndPush(Uri.parse(MainRoutes.homePageRoute));
          }
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: kSecondaryColor,
            appBar: AppBar(
              elevation: 4.0,
              backgroundColor: kSecondaryColor,
              centerTitle: false,
              title: const Text(
                "Opinionx",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding / 4),
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<UserHomeBloc>(context)
                          .add(UserHomeAskQueryRequested());
                    },
                    child: const Text(
                      "Post a Query",
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
            drawer: MainDrawer(),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      // color: Colors.black45.withOpacity(0.4),
                      color: kSecondaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SelectableText(
                          "Help Your Juniors !",
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: kMaxWidth),
                      color: kSecondaryColor,
                      child: SafeArea(child: QueryList()),
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
