import 'dart:convert';
import 'package:flutter/material.dart';

class ChatMessage {
  final String sender;
  final String message;
  final String sessionId; // Add sessionId field

  ChatMessage({required this.sender, required this.message, required this.sessionId});

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'message': message,
      'sessionId': sessionId, // Include sessionId in the map
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map['sender'],
      message: map['message'],
      sessionId: map['sessionId'], // Retrieve sessionId from the map
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source));
}
