import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationProvider extends ChangeNotifier {
  List<Map<String, String>> conversation = [];

  ConversationProvider() {
    loadConversation();
  }
  void clearConversation() {
    conversation.clear();
    saveConversation(); // update local storage if needed
    notifyListeners();
  }

  void addUserMessage(String message) {
    conversation.add({"user": message});
    saveConversation();
    notifyListeners();
  }

  void addGeminiMessage(String message) {
    conversation.add({"gemini": message});
    saveConversation();
    notifyListeners();
  }

  Future<void> loadConversation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("conversation");
    if (data != null) {
      List<dynamic> decoded = json.decode(data);
      conversation = List<Map<String, String>>.from(
          decoded.map((e) => Map<String, String>.from(e)));
      notifyListeners();
    }
  }

  Future<void> saveConversation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(conversation);
    await prefs.setString("conversation", data);
  }
}
