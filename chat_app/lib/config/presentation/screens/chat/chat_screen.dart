import 'package:chat_app/config/presentation/widgets/chat/message_field_box.dart';
import 'package:chat_app/config/presentation/widgets/chat/my_message_bubble.dart';
import 'package:chat_app/config/presentation/widgets/chat/other_message_bubble.dart';
import 'package:flutter/material.dart';

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
              'https://marvel-b1-cdn.bc0a.com/f00000000163918/www.care.org/wp-content/uploads/2021/04/alexandra-daddario-bio.webp',
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
    //SafeArea is for dont allow content in the buttom area
    return SafeArea(
      child: Column(
        children: [
          //Expanded is for expand the widget to the all available screen space
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return (index % 2 == 0)
                    ? const OtherMessageBubble()
                    : const MyMessageBubble();
              },
            ),
          ),
          MessageFieldBox()
        ],
      ),
    );
  }
}
