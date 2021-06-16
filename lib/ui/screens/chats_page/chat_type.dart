import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/core/api/functions/chat_functions.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';

import 'chat_users.dart';

class ChatType extends StatefulWidget {
  @override
  _ChatTypeState createState() => _ChatTypeState();
}

class _ChatTypeState extends State<ChatType> {
  int grVal = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              RadioListTile(
                value: 0,
                groupValue: grVal,
                onChanged: (int val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Student'),
              ),
              RadioListTile(
                value: 1,
                groupValue: grVal,
                onChanged: (int val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Teacher'),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade800,
            height: 0.0,
          ),
          const ListTile(
            dense: true,
            title: Text("Chats"),
          ),
          Divider(
            color: Colors.grey.shade800,
            height: 0.0,
          ),
          StreamProvider<List<ChatModel>>.value(
            value: grVal == 0
                ? ChatFunctions().userStudentList
                : ChatFunctions().userTeacherList,
            child: ChatUsers(),
          ),
        ],
      ),
    );
  }
}
