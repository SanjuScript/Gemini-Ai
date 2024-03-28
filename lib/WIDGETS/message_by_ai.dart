import 'dart:developer';

import 'package:chatbot_ai/HELPER/url_launcher.dart';
import 'package:chatbot_ai/PROVIDER/clipboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class MessageByAi extends StatelessWidget {
  final String data;
  const MessageByAi({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI model',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: MarkdownBody(
                    selectable: true,
                    data: data,
                    onTapLink: (text, href, title) async {
                      // log('Text :$text');
                      // log('Link:$href');
                      await UrlLaunch.launchurl(context, href);
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: IconButton(
              onPressed: () {
                Provider.of<ClipboardProvider>(context, listen: false)
                    .copyToClipboard(data, context);
              },
              icon: const Icon(Icons.copy_outlined, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
