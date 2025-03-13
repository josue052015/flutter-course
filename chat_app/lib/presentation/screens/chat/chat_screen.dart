import 'package:chat_app/domain/entities/message.dart';
import 'package:chat_app/presentation/providers/chat_provider.dart';
import 'package:chat_app/presentation/widgets/chat/message_field_box.dart';
import 'package:chat_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:chat_app/presentation/widgets/chat/other_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://www.care.org/wp-content/uploads/2021/04/alexandra-daddario-bio.webp',
             
            ),
          ),
        ),
        title: Text('Mi princesa 💕'),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    //SafeArea is for dont allow content in the buttom area
    return SafeArea(
      child: Column(
        children: [
          //Expanded is for expand the widget to the all available screen space
          Expanded(
            child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];
                return (message.fromMessage == FromWho.other)
                    ? const OtherMessageBubble()
                    : MyMessageBubble(
                      message: Message(
                        text: message.text,
                        fromMessage: FromWho.me,
                      ),
                    );
              },
            ),
          ),
          MessageFieldBox(),
        ],
      ),
    );
  }
}
