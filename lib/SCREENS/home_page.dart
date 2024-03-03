import 'package:chatbot_ai/SCREENS/chat_page.dart';
import 'package:chatbot_ai/SCREENS/simply_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbot_ai/controller/chat_controller.dart';
import 'package:chatbot_ai/model/chat_message_model.dart';
import 'package:chatbot_ai/widgets/history_message_card.dart';
import 'package:chatbot_ai/widgets/styled_containers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> _sessionIds;
  late Future<List<ChatMessage>> chatsee;
  @override
  void initState() {
    super.initState();
    _sessionIds = ChatHistoryManager.getSessionIds();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.12,
              ),
              SizedBox(
                height: size.height * 0.16,
                width: size.width * 0.90,
                child: StyledContainer(
                  buttontapped: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ChatPage()),
                    // );
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JioSaavnSongs()),
                    );
                  },
                  color: Color.fromARGB(205, 63, 179, 199),
                  buttonText: 'New chat..',
                ),
              ),
              FutureBuilder<List<String>>(
                future: _sessionIds,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final sessionIds = snapshot.data!;
                  // setState(() {

                  // });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sessionIds.map((sessionId) {
                      return FutureBuilder<List<ChatMessage>>(
                        future:
                            ChatHistoryManager.getMessagesForSession(sessionId)
                                as Future<List<ChatMessage>>?,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.data!.isEmpty) {
                            return Text(snapshot.data.toString());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          final sessionMessages = snapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Session: $sessionId'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: sessionMessages.map((message) {
                                  return ListTile(
                                    title: Text(message.sender),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryMessageCard(
                                                    sessionId: sessionId)),
                                      );
                                    },
                                    subtitle: Text(message.message),
                                  );
                                }).toList(),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
