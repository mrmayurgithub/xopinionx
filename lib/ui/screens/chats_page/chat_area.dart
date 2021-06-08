import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/message_bubble.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/chats_page/bloc/chat_bloc.dart';
import 'package:xopinionx/ui/screens/chats_page/chat_provider.dart';

import 'chats_screen.dart';

final _firestore = FirebaseFirestore.instance;

class ChatArea extends StatefulWidget {
  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  @override
  Widget build(BuildContext context) {
    final _ch = Provider.of<ChatSelectionProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Text(
            _ch.selectedChat.studentId,
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('chats')
              .doc(_ch.selectedChat.chatId)
              .collection('messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            List<MessageBubble> messageBubbles = [];
            print(" ${snapshot.data} CHATAREA");
            if (snapshot != null) {
              final messages = snapshot.data.docs.reversed;
              for (var msg in messages) {
                final json = msg.data();
                final messageText = json['text'];
                final messageSender = json['sender'];
                final currentUser = globalUser.email;
                final messageBubble = MessageBubble(
                  sender: messageSender,
                  msg: messageText,
                  isMe: globalUser.email == currentUser,
                );
                messageBubbles.add(messageBubble);
              }
            }
            return ListView(
              shrinkWrap: true,
              reverse: true,
              children: snapshot != null ? messageBubbles : [],
            );
          },
        ),
      ],
    );
  }
}
