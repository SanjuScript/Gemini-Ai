import 'package:chatbot_ai/MODEL/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
// import 'package:your_project_name_here/model/chat_message.dart';

class ChatHistoryManager {
  static final ValueNotifier<List<ChatMessage>> chatHistoryNotifier = ValueNotifier([]);
  static const String _boxName = 'chat_history';

  static int get chatHistoryLength => chatHistoryNotifier.value.length;

  static Future<void> initChatHistory() async {
    await Hive.initFlutter();
   

    await getAllChatMessages();
  }

  static String generateSessionId() {
    return const Uuid().v4(); // Generate a unique session identifier
  }

  static Future<void> saveChatMessage(ChatMessage message) async {
    final chatHistoryBox = Hive.box<ChatMessage>(_boxName);
    await chatHistoryBox.add(message);

    chatHistoryNotifier.value.add(message);
    chatHistoryNotifier.notifyListeners();
  }

  static Future<void> getAllChatMessages() async {
    final chatHistoryBox = Hive.box<ChatMessage>(_boxName);

    chatHistoryNotifier.value.clear();
    chatHistoryNotifier.value.addAll(chatHistoryBox.values);

    chatHistoryNotifier.notifyListeners();
  }

  static Future<List<String>> getSessionIds() async {
    final chatHistoryBox = Hive.box<ChatMessage>(_boxName);
    final chatMessages = chatHistoryBox.values.toList().cast<ChatMessage>();
    final sessionIds = chatMessages.map((message) => message.sessionId).toSet().toList();
    return sessionIds;
  }

  static Future<List<ChatMessage>> getMessagesForSession(String sessionId) async {
    final chatHistoryBox = Hive.box<ChatMessage>(_boxName);
    final chatMessages = chatHistoryBox.values.where((message) => message.sessionId == sessionId).toList().cast<ChatMessage>();
    return chatMessages;
  }

  static Future<void> deleteAllChatMessages() async {
    final chatHistoryBox = Hive.box<ChatMessage>(_boxName);
    await chatHistoryBox.clear();

    chatHistoryNotifier.value.clear();
    chatHistoryNotifier.notifyListeners();
  }
}
