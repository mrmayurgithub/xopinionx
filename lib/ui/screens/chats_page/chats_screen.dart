import 'package:flutter/material.dart';
import 'package:xopinionx/ui/components/drawer.dart';

class ChatPage extends StatelessWidget {
  static const id = 'chats_screen';
  @override
  Widget build(BuildContext context) {
    return ChatPageMainBody();
  }
}

class ChatPageMainBody extends StatefulWidget {
  @override
  _ChatPageMainBodyState createState() => _ChatPageMainBodyState();
}

class _ChatPageMainBodyState extends State<ChatPageMainBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
