import 'package:flutter/material.dart';
import '../gemini_service.dart';
import '../models/chat_model.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  List<ChatModel> messages = [];
  bool loading = false;

  void sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    final input = controller.text;

    setState(() {
      messages.add(ChatModel(role: "user", text: input));
      controller.clear();
      loading = true;
    });

    final response = await GeminiService.generateTests(input);

    setState(() {
      messages.add(ChatModel(role: "ai", text: response));
      loading = false;
    });
  }

  void newChat() {
    setState(() {
      messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(newChat: newChat),

          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: const Text("🤖 AI Test Generator"),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.brightness_6),
                      onPressed: widget.toggleTheme,
                    )
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(msg: messages[index]);
                    },
                  ),
                ),

                if (loading) const CircularProgressIndicator(),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Paste Dart code...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: sendMessage,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}