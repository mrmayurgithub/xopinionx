import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';
import 'package:xopinionx/ui/screens/chats_page/chat_provider.dart';

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
                      overflow: TextOverflow.ellipsis,
                    ),
                    // tileColor: sChat.selectedChat.problemId ==
                    //         _chatlist[index].problemId
                    //     ? Colors.grey.shade800
                    //     : Colors.grey.shade700,
                    onTap: () {
                      sChat.setChat(chat: _chatlist[index]);
                      Scaffold.of(context).setState(() {});
                    },
                  );
                },
              );
  }
}
