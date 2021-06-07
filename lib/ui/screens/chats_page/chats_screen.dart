import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:xopinionx/api/functions/chat_functions.dart';
import 'package:xopinionx/api/models/chat_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/message_bubble.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/chats_page/bloc/chat_bloc.dart';

final _firestore = FirebaseFirestore.instance;

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(ChatListRequested()),
      child: MainChatPage(),
    );
  }
}

class MainChatPage extends StatefulWidget {
  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends State<MainChatPage> {
  bool chatSelected = false;
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sChat = Provider.of<ChatSelectionProvider>(context, listen: false);

    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatInitialized) {
          showProgress(context);
        }
        if (state is NoChatSelected) {
          chatSelected = false;
        }
        if (state is ChatSelected) {
          chatSelected = true;
        }
        if (state is ChatInProgress) {
          showProgress(context);
        }
        if (state is ChatFailure) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
          ),
          drawer: MainDrawer(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              TextEditingController().clear();
            },
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: kMaxWidth,
                ),
                color: kSecondaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  fontSize: 13,
                                  color: kMenuTextColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Search from your chats",
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: kMenuTextColor,
                                  ),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey.shade900,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade800,
                              height: 0.0,
                            ),
                            ChatType(),
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      width: 1.0,
                      color: Colors.black45,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                            ),
                            height: MediaQuery.of(context).size.height - 100,
                            child: sChat.selectedChat != null
                                ? ChatArea()
                                : const Center(
                                    child: Text(
                                      "No chat to show",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              border: const Border(
                                top: BorderSide(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 4,
                              vertical: kDefaultPadding / 5,
                            ),
                            child: Center(
                              child: TextField(
                                controller: messageTextController,
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _firestore
                                          .collection('chats')
                                          .doc(sChat.selectedChat.chatId)
                                          .collection('messages')
                                          .add({
                                        'text': messageTextController.text,
                                        'sender': globalUser.email,
                                      }).then((value) {
                                        messageTextController.clear();
                                      });
                                    },
                                    icon: const Icon(Icons.send),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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
                    tileColor: sChat.selectedChat.problemId ==
                            _chatlist[index].problemId
                        ? Colors.grey.shade800
                        : Colors.grey.shade700,
                    onTap: () {
                      sChat.setChat(chat: _chatlist[index]);
                    },
                  );
                },
              );
  }
}

class ChatArea extends StatefulWidget {
  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  @override
  Widget build(BuildContext context) {
    final _ch = Provider.of<ChatSelectionProvider>(context);
    return StreamBuilder<QuerySnapshot>(
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
          reverse: true,
          children: snapshot != null ? messageBubbles : [],
        );
      },
    );
  }
}

class ChatSelectionProvider with ChangeNotifier {
  ChatModel _selectedChat;
  ChatModel get selectedChat => _selectedChat;
  void setChat({@required ChatModel chat}) {
    _selectedChat = chat;
    notifyListeners();
  }
}
