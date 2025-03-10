import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
   
   final focusNode = FocusNode();

   final textController = TextEditingController();

    final borderConfig = OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20)
        );

    void onSubmitMsg(){
      textController.clear();
      focusNode.requestFocus();
    };

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
            onSubmitMsg();
          },
        ),
      ),
      onFieldSubmitted: (value) {
        onSubmitMsg();
      }
    );
  }
}
