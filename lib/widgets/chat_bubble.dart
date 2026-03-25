import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel msg;

  const ChatBubble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: msg.role == "user"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: msg.role == "user"
              ? Colors.blue
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: SelectableText(
          msg.text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}