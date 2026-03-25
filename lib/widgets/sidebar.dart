import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback newChat;

  const Sidebar({super.key, required this.newChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.grey[900],
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text("💬 Chats",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          ElevatedButton(
            onPressed: newChat,
            child: const Text("➕ New Chat"),
          )
        ],
      ),
    );
  }
}