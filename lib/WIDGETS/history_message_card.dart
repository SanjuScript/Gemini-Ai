import 'package:chatbot_ai/CONTROLLER/chat_controller.dart';
import 'package:chatbot_ai/MODEL/chat_message_model.dart';
import 'package:chatbot_ai/WIDGETS/message_by_ai.dart';
import 'package:chatbot_ai/WIDGETS/message_by_user.dart';
import 'package:flutter/material.dart';

class HistoryMessageCard extends StatelessWidget {
  final String sessionId;

  const HistoryMessageCard({Key? key, required this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History - Session: $sessionId'),
      ),
      body: FutureBuilder<List<ChatMessage>>(
        future: ChatHistoryManager.getMessagesForSession(sessionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final sessionMessages = snapshot.data!;

          return ListView.builder(
            itemCount: sessionMessages.length,
            itemBuilder: (context, index) {
              final message = sessionMessages[index];
              return ListTile(
                title: Text(message.sender),
                subtitle: Text(message.message),
              );
            },
          );
        },
      ),
    );
  }
}