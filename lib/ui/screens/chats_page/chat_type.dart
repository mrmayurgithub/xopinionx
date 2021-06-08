import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/core/api/functions/chat_functions.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/message_bubble.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/chats_page/bloc/chat_bloc.dart';

import 'chat_users.dart';
import 'chats_screen.dart';

final _firestore = FirebaseFirestore.instance;

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
