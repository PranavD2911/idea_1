// To parse this JSON data, do
//
//     final geminiResponseModel = geminiResponseModelFromJson(jsonString);

import 'dart:convert';

GeminiResponseModel geminiResponseModelFromJson(String str) =>
    GeminiResponseModel.fromJson(json.decode(str));

String geminiResponseModelToJson(GeminiResponseModel data) =>
    json.encode(data.toJson());

class GeminiResponseModel {
  List<CandidateResponseModel>? candidates;
  UsageMetadata? usageMetadata;
  String? modelVersion;

  GeminiResponseModel({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
  });

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) =>
      GeminiResponseModel(
        candidates: json["candidates"] == null
            ? []
            : List<CandidateResponseModel>.from(json["candidates"]!
                .map((x) => CandidateResponseModel.fromJson(x))),
        usageMetadata: json["usageMetadata"] == null
            ? null
            : UsageMetadata.fromJson(json["usageMetadata"]),
        modelVersion: json["modelVersion"],
      );

  Map<String, dynamic> toJson() => {
        "candidates": candidates == null
            ? []
            : List<dynamic>.from(candidates!.map((x) => x.toJson())),
        "usageMetadata": usageMetadata?.toJson(),
        "modelVersion": modelVersion,
      };
}

class CandidateResponseModel {
  ContentResponse? content;
  String? finishReason;
  CitationMetadataResponse? citationMetadata;
  double? avgLogprobs;

  CandidateResponseModel({
    this.content,
    this.finishReason,
    this.citationMetadata,
    this.avgLogprobs,
  });

  factory CandidateResponseModel.fromJson(Map<String, dynamic> json) =>
      CandidateResponseModel(
        content: json["content"] == null
            ? null
            : ContentResponse.fromJson(json["content"]),
        finishReason: json["finishReason"],
        citationMetadata: json["citationMetadata"] == null
            ? null
            : CitationMetadataResponse.fromJson(json["citationMetadata"]),
        avgLogprobs: json["avgLogprobs"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
        "finishReason": finishReason,
        "citationMetadata": citationMetadata?.toJson(),
        "avgLogprobs": avgLogprobs,
      };
}

class CitationMetadataResponse {
  List<CitationSource>? citationSources;

  CitationMetadataResponse({
    this.citationSources,
  });

  factory CitationMetadataResponse.fromJson(Map<String, dynamic> json) =>
      CitationMetadataResponse(
        citationSources: json["citationSources"] == null
            ? []
            : List<CitationSource>.from(json["citationSources"]!
                .map((x) => CitationSource.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "citationSources": citationSources == null
            ? []
            : List<dynamic>.from(citationSources!.map((x) => x.toJson())),
      };
}

class CitationSource {
  int? startIndex;
  int? endIndex;
  String? uri;

  CitationSource({
    this.startIndex,
    this.endIndex,
    this.uri,
  });

  factory CitationSource.fromJson(Map<String, dynamic> json) => CitationSource(
        startIndex: json["startIndex"],
        endIndex: json["endIndex"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "startIndex": startIndex,
        "endIndex": endIndex,
        "uri": uri,
      };
}

class ContentResponse {
  List<PartResponse>? parts;
  String? role;

  ContentResponse({
    this.parts,
    this.role,
  });

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      ContentResponse(
        parts: json["parts"] == null
            ? []
            : List<PartResponse>.from(
                json["parts"]!.map((x) => PartResponse.fromJson(x))),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
        "role": role,
      };
}

class PartResponse {
  String? text;

  PartResponse({
    this.text,
  });

  factory PartResponse.fromJson(Map<String, dynamic> json) => PartResponse(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class UsageMetadata {
  int? promptTokenCount;
  int? candidatesTokenCount;
  int? totalTokenCount;
  List<TokensDetail>? promptTokensDetails;
  List<TokensDetail>? candidatesTokensDetails;

  UsageMetadata({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
    this.promptTokensDetails,
    this.candidatesTokensDetails,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) => UsageMetadata(
        promptTokenCount: json["promptTokenCount"],
        candidatesTokenCount: json["candidatesTokenCount"],
        totalTokenCount: json["totalTokenCount"],
        promptTokensDetails: json["promptTokensDetails"] == null
            ? []
            : List<TokensDetail>.from(json["promptTokensDetails"]!
                .map((x) => TokensDetail.fromJson(x))),
        candidatesTokensDetails: json["candidatesTokensDetails"] == null
            ? []
            : List<TokensDetail>.from(json["candidatesTokensDetails"]!
                .map((x) => TokensDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "promptTokenCount": promptTokenCount,
        "candidatesTokenCount": candidatesTokenCount,
        "totalTokenCount": totalTokenCount,
        "promptTokensDetails": promptTokensDetails == null
            ? []
            : List<dynamic>.from(promptTokensDetails!.map((x) => x.toJson())),
        "candidatesTokensDetails": candidatesTokensDetails == null
            ? []
            : List<dynamic>.from(
                candidatesTokensDetails!.map((x) => x.toJson())),
      };
}

class TokensDetail {
  String? modality;
  int? tokenCount;

  TokensDetail({
    this.modality,
    this.tokenCount,
  });

  factory TokensDetail.fromJson(Map<String, dynamic> json) => TokensDetail(
        modality: json["modality"],
        tokenCount: json["tokenCount"],
      );

  Map<String, dynamic> toJson() => {
        "modality": modality,
        "tokenCount": tokenCount,
      };
}
