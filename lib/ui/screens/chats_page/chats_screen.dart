import 'package:flutter/material.dart';
import 'package:xopinionx/ui/components/drawer.dart';

class ChatPage extends StatelessWidget {
  static const id = 'chats_screen';
  final String chatUserId;

  const ChatPage({Key key, this.chatUserId}) : super(key: key);
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 200,
        ),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: 400,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey[200],
                  child: ListView(
                    shrinkWrap: true,
                  ),
                ),
              ),
              VerticalDivider(
                width: 1.0,
              ),
              Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height - 100,
                    width: 1100,
                    child: SingleChildScrollView(),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 40,
                    width: 1100,
                    child: TextField(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
