import 'package:chatbot_ai/WIDGETS/message_by_ai.dart';
import 'package:chatbot_ai/WIDGETS/message_by_user.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.sendByUser,
    required this.message,
  }) : super(key: key);

  final bool sendByUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    if (sendByUser) {
      return MessageByUser(data: message);
    } else {
      return MessageByAi(data: message);
    }
  }
}
