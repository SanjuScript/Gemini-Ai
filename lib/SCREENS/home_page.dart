import 'package:chatbot_ai/HELPER/app_bar.dart';
import 'package:chatbot_ai/HELPER/bg_helper.dart';
import 'package:chatbot_ai/SCREENS/chat_page.dart';
import 'package:chatbot_ai/WIDGETS/positioned_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        },
        child: Container(
          height: size.height * .07,
          width: size.width * .40,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.9),
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.blue.withOpacity(.9),
                    spreadRadius: 2,
                    offset: const Offset(2, -2)),
                const BoxShadow(
                    color: Colors.blue, blurRadius: 8, offset: Offset(-2, 2))
              ]),
          child: Center(
            child: Text(
              'New Chat',
              style: TextStyle(
                fontFamily: 'rounder',
                fontWeight: FontWeight.w300,
                letterSpacing: .6,
                fontSize: 22,
                color: Colors.white.withOpacity(.8),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomAppBar2(),
          Positioned(
            top: size.height * .10,
            right: 15,
            left: 15,
            bottom: size.height * .22,
            child: Text(
              'Mind Mate AI',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'rounder',
                fontWeight: FontWeight.w300,
                letterSpacing: .6,
                fontSize: 25,
                color: Colors.white.withOpacity(.8),
              ),
            ),
          ),
          Positioned(
            top: size.height * .18,
            right: 15,
            left: 15,
            bottom: size.height * .20,
            child: Text(
              """Mind Mate" is your intelligent companion in the digital world, offering a personalized and insightful chat experience. With Mind Mate, engage in meaningful conversations, seek advice, and discover new perspectives. Whether you're looking for a friendly chat or seeking guidance on a wide range of topics, Mind Mate is here to support your mental well-being and foster a deeper connection with your thoughts and ideas. Explore the realms of knowledge and creativity with your trusted ally, Mind Mate, your gateway to a more insightful and fulfilling digital experience.""",
              style: TextStyle(
                fontFamily: 'rounder',
                fontWeight: FontWeight.w300,
                letterSpacing: .6,
                fontSize: 15,
                color: Colors.white.withOpacity(.8),
              ),
            ),
          ),
        PositionedText()
        ],
      ),
    );
  }
}
