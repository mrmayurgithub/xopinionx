import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/components/message_bubble.dart';
import 'package:xopinionx/ui/screens/chats_page/chat_provider.dart';

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
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            // ignore: prefer_final_locals
            List<MessageBubble> messageBubbles = [];
            if (snapshot != null) {
              final messages = snapshot.data.docs.reversed;
              for (final msg in messages) {
                final json = msg.data();
                final messageText = json['text'];
                final messageSender = json['sender'];
                final currentUser = globalUser.email;
                final messageBubble = MessageBubble(
                  sender: messageSender.toString(),
                  msg: messageText.toString(),
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
