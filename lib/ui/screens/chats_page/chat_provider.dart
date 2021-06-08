import 'package:flutter/material.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';

class ChatSelectionProvider with ChangeNotifier {
  ChatModel _selectedChat;
  ChatModel get selectedChat => _selectedChat;
  void setChat({@required ChatModel chat}) {
    _selectedChat = chat;
    notifyListeners();
  }
}
