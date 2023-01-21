// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.body,
    required this.sentAt,
    required this.isSeen,
    required this.isMine,
  });

  String body;
  DateTime sentAt;
  bool isSeen;
  bool isMine;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        body: json["body"],
        sentAt: DateTime.parse(json["sentAt"]),
        isSeen: json["isSeen"],
        isMine: json["isMine"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "sentAt":
            "${sentAt.year.toString().padLeft(4, '0')}-${sentAt.month.toString().padLeft(2, '0')}-${sentAt.day.toString().padLeft(2, '0')}",
        "isSeen": isSeen,
        "isMine": isMine,
      };
}
