import 'package:chat_app/presentation/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final focusNode = FocusNode();

    final textController = TextEditingController();

    final borderConfig = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );

    void onSubmitMsg(String text) {
      chatProvider.sendMessage(text);
      textController.clear();
      focusNode.requestFocus();
    }

    return TextFormField(
      onTapUpOutside: (event) {
        focusNode.unfocus();
      },
      controller: textController,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'End your message with "?"',
        enabledBorder: borderConfig,
        focusedBorder: borderConfig,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(Icons.send_outlined),
          onPressed: () {
             final textValue = textController.value.text;
            onSubmitMsg(textValue);
          },
        ),
      ),
      onFieldSubmitted: (value) {
        onSubmitMsg(value);
      },
    );
  }
}
