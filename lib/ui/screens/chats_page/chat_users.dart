import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/message_bubble.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/chats_page/bloc/chat_bloc.dart';
import 'package:xopinionx/ui/screens/chats_page/chat_provider.dart';
import 'package:xopinionx/ui/screens/chats_page/chats_screen.dart';

final _firestore = FirebaseFirestore.instance;

class ChatUsers extends StatefulWidget {
  @override
  _ChatUsersState createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  @override
  Widget build(BuildContext context) {
    final sChat = Provider.of<ChatSelectionProvider>(context, listen: false);

    final _chatlist = Provider.of<List<ChatModel>>(context);
    return _chatlist == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _chatlist.isEmpty
            ? const Center(
                child: Text("No Chats to show"),
              )
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _chatlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _chatlist[index].problemId,
                      // "a",
                      overflow: TextOverflow.ellipsis,
                    ),
                    // tileColor: sChat.selectedChat.problemId ==
                    //         _chatlist[index].problemId
                    //     ? Colors.grey.shade800
                    //     : Colors.grey.shade700,
                    onTap: () {
                      sChat.setChat(chat: _chatlist[index]);
                    },
                  );
                },
              );
  }
}
