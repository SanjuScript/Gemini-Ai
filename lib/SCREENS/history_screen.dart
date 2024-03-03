// import 'package:chatbot_ai/MODEL/chat_message_model.dart';
// import 'package:chatbot_ai/PROVIDER/chat_provider.dart';
// import 'package:chatbot_ai/WIDGETS/history_message_card.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChatHistoryPage extends StatefulWidget {
//   final List<ChatMessage> chatHistory;

//   const ChatHistoryPage({Key? key, required this.chatHistory})
//       : super(key: key);

//   @override
//   State<ChatHistoryPage> createState() => _ChatHistoryPageState();
// }

// class _ChatHistoryPageState extends State<ChatHistoryPage> {
//   @override
//   void initState() {
//     Provider.of<ChatScreenState>(context,listen: false).loadChatHistory();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat History'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.chatHistory.length,
//         itemBuilder: (context, index) {
//           final message = widget.chatHistory[index];
//           return HistoryMessageCard(message: message);
//         },
//       ),
//     );
//   }
// }
