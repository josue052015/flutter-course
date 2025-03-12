import 'package:chat_app/domain/entities/message.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> messages = [Message(text: 'Hello', fromMessage: FromWho.me)];

  Future<void> sendMessage(String text) async {
    final message = Message(text: text, fromMessage: FromWho.me);
    messages.add(message);
    notifyListeners(); 
  }
}
