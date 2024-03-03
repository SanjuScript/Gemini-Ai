import 'package:chatbot_ai/MODEL/chat_message_model.dart';
import 'package:chatbot_ai/PROVIDER/chat_provider.dart';
import 'package:chatbot_ai/PROVIDER/session_counter.dart';
import 'package:chatbot_ai/SCREENS/history_screen.dart';
import 'package:chatbot_ai/WIDGETS/message_card.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> chatHistory = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final scounter = Provider.of<SessionCounterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini AI'),
      ),
      body: ChangeNotifierProvider.value(
        value: Provider.of<ChatScreenState>(context),
        child: Consumer<ChatScreenState>(
          builder: (context, state, child) {
            return Stack(
              children: [
                ListView.custom(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 90),
                  reverse: true,
                  controller: state.scrollController,
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var content = state.history.reversed.toList()[index];
                      var text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageCard(
                        sendByUser: content.role == 'user',
                        message: text,
                      );
                    },
                    childCount: state.history.length,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(top: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: size.height * 0.07,
                            child: TextField(
                              cursorColor: Colors.amber,
                              controller: _textController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Ask me anything...',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onDoubleTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ChatHistoryPage(
                            //             chatHistory: state.chatHistory)));
                          },
                          onTap: () {
                            state.history.add(Content(
                                'user', [TextPart(_textController.text)]));
                            state.sendChatMessage(
                              _textController.text,
                              state.history.length,
                            );
                            _textController.clear();
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                  spreadRadius: 3,
                                  color: Colors.black.withOpacity(0.05),
                                ),
                              ],
                            ),
                            child: state.loading
                                ? const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
