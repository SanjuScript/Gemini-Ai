import 'package:chatbot_ai/CONTROLLER/chat_controller.dart';
import 'package:chatbot_ai/DATABASE/chat_model.dart';
import 'package:chatbot_ai/PROVIDER/chat_provider.dart';
import 'package:chatbot_ai/PROVIDER/clipboard_provider.dart';
import 'package:chatbot_ai/PROVIDER/session_counter.dart';
import 'package:chatbot_ai/SCREENS/chat_page.dart';
import 'package:chatbot_ai/SCREENS/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ChatModelAdapter().typeId)) {
    Hive.registerAdapter(ChatModelAdapter());
  }

    await Hive.openBox<ChatModel>('chat_history');
  

  // ChatHistoryManager.initHive();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ChatScreenState(),
      ),
      ChangeNotifierProvider(
        create: (context) => ClipboardProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SessionCounterProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
