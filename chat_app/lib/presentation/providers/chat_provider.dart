import 'dart:async';

import 'package:chat_app/config/helpers/get_answer.dart';
import 'package:chat_app/domain/entities/message.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
 
  final GetAnswer getAnswer = GetAnswer();
  List<Message> messages = [];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final message = Message(text: text, fromMessage: FromWho.me);
    messages.add(message);
    if(message.text.endsWith('?')) await herReply();
    notifyListeners();
    moveScroll();
  
  }

  void moveScroll() {
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> herReply() async {
    final herReply = await getAnswer.getAnswer();
    messages.add(herReply);
    notifyListeners();
    moveScroll();
  }
}
