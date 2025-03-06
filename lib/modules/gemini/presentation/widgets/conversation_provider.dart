import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:idea_1/modules/gemini/data/models/chat_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationProvider extends ChangeNotifier {
  List<ChatMessage> conversation = [];

  ConversationProvider() {
    loadConversation();
  }

  void addUserMessage(String message) {
    conversation.add(ChatMessage(
      sender: 'user',
      message: message,
      timestamp: DateTime.now(),
    ));
    saveConversation();
    notifyListeners();
  }

  void addGeminiMessage(String message) {
    conversation.add(ChatMessage(
      sender: 'gemini',
      message: message,
      timestamp: DateTime.now(),
    ));
    saveConversation();
    notifyListeners();
  }

  void clearConversation() {
    conversation.clear();
    saveConversation();
    notifyListeners();
  }

  Future<void> loadConversation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("conversation");
    if (data != null) {
      List<dynamic> decoded = json.decode(data);
      conversation = decoded
          .map((e) => ChatMessage.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> saveConversation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(conversation.map((e) => e.toJson()).toList());
    await prefs.setString("conversation", data);
  }
}
