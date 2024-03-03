import 'dart:convert';
import 'dart:developer';
import 'package:chatbot_ai/API/api.dart';
import 'package:chatbot_ai/CONTROLLER/chat_controller.dart';
import 'package:chatbot_ai/MODEL/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreenState extends ChangeNotifier {
  List<Content> history = [];
  // List<ChatMessage> chatHistory = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;
  bool loading = false;
  final ScrollController scrollController = ScrollController();
  String currentSessionId = ChatHistoryManager.generateSessionId();
  // final ChatHistory _chatHistory = ChatHistory();
  ChatScreenState() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: Api.api,
    );
    _chat = _model.startChat();
    loadChatHistory();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  Future<void> loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('chat_history');
    if (historyJson != null) {
      //   final List<dynamic> historyList = json.decode(historyJson);
      //   chatHistory = historyList
      //       .map((item) => ChatMessage.fromMap(Map<String, dynamic>.from(item)))
      //       .toList();
      //   notifyListeners();
      // }
    }
  }

  Future<void> saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    // final historyJson =
    //     json.encode(chatHistory.map((item) => item.toMap()).toList());
    // await prefs.setString('chat_history', historyJson);
  }

  Future<void> sendChatMessage(
      String message, int historyIndex) async {
    loading = true;
    notifyListeners();
    scrollDown();
    List<Part> parts = [];

    try {
      var response = _chat.sendMessageStream(
        Content.text(message),
      );

      // log(response.toString());
      await for (var item in response) {
        var text = item.text;
        if (text == null) {
          // _showError('No response from API.');
          return;
        } else {
          loading = false;
          parts.add(TextPart(text));
          if ((history.length - 1) == historyIndex) {
            history.removeAt(historyIndex);
          }

          history.insert(historyIndex, Content('model', parts));

          // final userMsg = ChatMessage(
          //     sender: 'user', message: message, sectionNumber: sectionIndex);
          await ChatHistoryManager.saveChatMessage(ChatMessage(
              sender: 'user', message: message, sessionId: currentSessionId));
          await ChatHistoryManager.saveChatMessage(ChatMessage(
              sender: 'model', message: text, sessionId: currentSessionId));
          // _chatHistory.addMessage(userMsg);
          // final modelMsg = ChatMessage(
          //     sender: 'model', message: text, sectionNumber: sectionIndex);
          // _chatHistory.addMessage(modelMsg);

          saveChatHistory();
          notifyListeners();
        }
      }
    } catch (e, t) {
      log(e.toString());
      log(t.toString());
      // _showError(e.toString());
      loading = false;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

  // void sendChatMessage(String text, int length) {}
