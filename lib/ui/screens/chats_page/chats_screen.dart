import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/api/models/chat_model.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/chats_page/bloc/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  // final ChatModel chatModel;

  // const ChatPage({@required this.chatModel});

  @override
  Widget build(BuildContext context) {
    //TODO: this is wrong
    ChatModel chatModel;
    return BlocProvider(
      create: (context) => ChatBloc()..add(ChatListRequested()),
      child: MainChatPage(
        chatModel: chatModel,
      ),
    );
  }
}

class MainChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const MainChatPage({@required this.chatModel});
  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends State<MainChatPage> {
  bool chatSelected = false;

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                          ),
                          child: Column(
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
                              ListView(
                                shrinkWrap: true,
                                children: [],
                              ),
                            ],
                          ),
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
                            child: widget.chatModel != null
                                ? ListView()
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
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.send,
                                    ),
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
