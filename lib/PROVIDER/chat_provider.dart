import 'dart:developer';
import 'package:chatbot_ai/API/api.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreenState extends ChangeNotifier {
  List<Content> history = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;
  bool loading = false;
  final ScrollController scrollController = ScrollController();

  ChatScreenState() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      // safetySettings: [
      //   SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
      //   SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      //   SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
      //   SafetySetting(HarmCategory.unspecified, HarmBlockThreshold.medium),
      //   SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
      // ],
      apiKey: Api.api,
    );
    _chat = _model.startChat();
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

  Future<void> sendChatMessage(
      String message, int historyIndex, BuildContext context) async {
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
          showError('No response from API.', context);
          return;
        } else {
          loading = false;
          parts.add(TextPart(text));
          if ((history.length - 1) == historyIndex) {
            history.removeAt(historyIndex);
          }

          history.insert(historyIndex, Content('model', parts));
          notifyListeners();
        }
      }
    } catch (e, t) {
      log(e.toString());
      log(t.toString());
      showError(e.toString(), context);
      loading = false;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

void showError(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Something went wrong'),
        content: SingleChildScrollView(
          child: SelectableText(message),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ],
      );
    },
  );
}
