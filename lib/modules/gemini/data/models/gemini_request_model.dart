// To parse this JSON data, do
//
//     final geminiRequestModel = geminiRequestModelFromJson(jsonString);

import 'dart:convert';

GeminiRequestModel geminiRequestModelFromJson(String str) =>
    GeminiRequestModel.fromJson(json.decode(str));

String geminiRequestModelToJson(GeminiRequestModel data) =>
    json.encode(data.toJson());

class GeminiRequestModel {
  List<Content>? contents;

  GeminiRequestModel({
    this.contents,
  });

  factory GeminiRequestModel.fromJson(Map<String, dynamic> json) =>
      GeminiRequestModel(
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class Content {
  List<Part>? parts;

  Content({
    this.parts,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: json["parts"] == null
            ? []
            : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
      };
}

class Part {
  String? text;

  Part({
    this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
