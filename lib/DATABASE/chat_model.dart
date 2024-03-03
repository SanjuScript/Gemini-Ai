import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0)
class ChatModel extends HiveObject {
  @HiveField(0)
  late String sender;

  @HiveField(1)
  late String message;

  @HiveField(2)
  late String sessionId; // Unique identifier for each session

  ChatModel({required this.sender, required this.message, required this.sessionId});
}
