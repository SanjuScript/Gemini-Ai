import 'package:chatbot_ai/HELPER/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageByUser extends StatelessWidget {
  final String data;
  const MessageByUser({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'You',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: MarkdownBody(
                    selectable: true,
                    data: data,
                    onTapLink: (text, href, title) async {
                      await UrlLaunch.launchurl(context, text);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
