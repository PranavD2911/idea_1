class GeminiAttributeModel {
  List<CandidateAttributeModel>? candidates;
  UsageMetadataAttribute? usageMetadata;
  String? modelVersion;

  GeminiAttributeModel({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
  });
}

class CandidateAttributeModel {
  ContentAttribute? content;
  String? finishReason;
  CitationMetadata? citationMetadata;
  double? avgLogprobs;

  CandidateAttributeModel({
    this.content,
    this.finishReason,
    this.citationMetadata,
    this.avgLogprobs,
  });
}

class CitationMetadata {
  List<CitationSourceAttribute>? citationSources;

  CitationMetadata({
    this.citationSources,
  });
}

class CitationSourceAttribute {
  int? startIndex;
  int? endIndex;
  String? uri;

  CitationSourceAttribute({
    this.startIndex,
    this.endIndex,
    this.uri,
  });
}

class ContentAttribute {
  List<PartAttribute>? parts;
  String? role;

  ContentAttribute({
    this.parts,
    this.role,
  });
}

class PartAttribute {
  String? text;

  PartAttribute({
    this.text,
  });
}

class UsageMetadataAttribute {
  int? promptTokenCount;
  int? candidatesTokenCount;
  int? totalTokenCount;
  List<TokensDetailAttribute>? promptTokensDetails;
  List<TokensDetailAttribute>? candidatesTokensDetails;

  UsageMetadataAttribute({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
    this.promptTokensDetails,
    this.candidatesTokensDetails,
  });
}

class TokensDetailAttribute {
  String? modality;
  int? tokenCount;

  TokensDetailAttribute({
    this.modality,
    this.tokenCount,
  });
}
