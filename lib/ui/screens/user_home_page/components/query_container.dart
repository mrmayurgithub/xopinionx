import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/core/api/models/problem_model.dart';
import 'package:xopinionx/global/tags_map.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/user_home_page/bloc/user_home_bloc.dart';
import 'package:xopinionx/ui/screens/user_home_page/components/report_content.dart';

// ignore: must_be_immutable
class QueryContainer extends StatelessWidget {
  ProblemModel ele;
  QueryContainer({@required this.ele});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: Colors.white,
      title: Text(
        ele.problemTitle.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: TextButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(tagsMap[ele.tag]),
              ),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.flag_outlined),
        color: Colors.white,
        onPressed: () async {
          return showDialog(
            context: context,
            builder: (context) {
              return ReportContent();
            },
          );
        },
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 6,
            horizontal: kDefaultPadding / 4,
          ),
          child: Text(
            ele.problemDescription,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ele.datePosted == null
                  ? const Text("Update")
                  : Text(
                      'Asked - ${ele.datePosted.split(" ").first}',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 10,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding / 5,
                right: kDefaultPadding / 6,
              ),
              child: TextButton(
                onPressed: () {
                  BlocProvider.of<UserHomeBloc>(context)
                      .add(UserHomeChatRequested(
                    studentId: ele.userId,
                    problemId: ele.problemId,
                  ));
                },
                style: TextButton.styleFrom(backgroundColor: Colors.grey[800]),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Chat'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
