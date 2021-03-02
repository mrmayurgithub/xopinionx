import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer(
      listener: (context, state) {
        if (state is UserQueriesInProgress) {}
        if (state is UserQueriesSuccess) {}
        if (state is ProblemChatLoaded) {}
        if (state is ProblemDeleted) {}
        if (state is ProblemEdited) {}
        if (state is ProblemSolved) {}
        if (state is UserQueriesFailure) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
