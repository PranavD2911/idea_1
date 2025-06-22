class ChatMessage {
  final String sender; // 'user' or 'gemini'
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  // Optional: convert to/from JSON if using local storage.
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        sender: json['sender'],
        message: json['message'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
