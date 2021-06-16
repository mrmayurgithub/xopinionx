import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/screens/history_page/bloc/history_bloc.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc()..add(UserHistoryRequested()),
      child: HistoryMainBody(),
    );
  }
}

class HistoryMainBody extends StatefulWidget {
  @override
  _HistoryMainBodyState createState() => _HistoryMainBodyState();
}

class _HistoryMainBodyState extends State<HistoryMainBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) async {
        if (state is HistoryInitial) {}
        if (state is HistorySuccess) {}
        if (state is HistoryFailure) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: MainDrawer(),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('History'),
                  const ExpansionTile(
                    title: Text('data'),
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
