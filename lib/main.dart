import 'package:chatbot_ai/PROVIDER/chat_provider.dart';
import 'package:chatbot_ai/PROVIDER/clipboard_provider.dart';
import 'package:chatbot_ai/SCREENS/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ChatScreenState(),
      ),
      ChangeNotifierProvider(
        create: (context) => ClipboardProvider(),
      ),
    ],
    child: const MyApp(),
    
  ));
   SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.dark),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
