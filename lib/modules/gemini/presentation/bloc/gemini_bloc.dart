import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_attribute_model.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_request_model.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_response_model.dart';
import 'package:idea_1/modules/gemini/data/repositories/gemini_repo_impl.dart';
import 'package:idea_1/services/error/server_failures.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final TextEditingController chatController = TextEditingController();
  GeminiBloc() : super(GeminiInitial()) {
    on<GeminiEvent>((event, emit) {});
    on<GeminiRequestEvent>(geminiRequest);
  }

  FutureOr<void> geminiRequest(
      GeminiRequestEvent event, Emitter<GeminiState> emit) async {
    emit(GeminiLoadingState());
    try {
      GeminiRequestModel geminiRequestModel = event.geminiRequestModel;
      Either<Failure, dynamic> response = await GeminiRepoImpl()
          .postData(geminiRequestModel: geminiRequestModel);
      if (response.isLeft) {
        emit(GeminiFailureState());
      } else {
        GeminiResponseModel geminiResponseModel =
            GeminiResponseModel.fromJson(response.right);
        GeminiAttributeModel geminiAttributeModel = GeminiAttributeModel(
          candidates: geminiResponseModel.candidates
                  ?.map((e) => CandidateAttributeModel(
                      avgLogprobs: e.avgLogprobs ?? 0,
                      citationMetadata: CitationMetadata(
                        citationSources: e.citationMetadata?.citationSources
                                ?.map((e) => CitationSourceAttribute(
                                    endIndex: e.endIndex ?? 0,
                                    startIndex: e.startIndex ?? 0,
                                    uri: e.uri ?? ""))
                                .toList() ??
                            [],
                      ),
                      content: ContentAttribute(
                        role: e.content?.role ?? "",
                        parts: e.content?.parts
                                ?.map((e) => PartAttribute(text: e.text ?? ""))
                                .toList() ??
                            [],
                      ),
                      finishReason: e.finishReason ?? ""))
                  .toList() ??
              [],
          modelVersion: geminiResponseModel.modelVersion,
          usageMetadata: UsageMetadataAttribute(
            candidatesTokenCount:
                geminiResponseModel.usageMetadata?.candidatesTokenCount ?? 0,
            promptTokenCount:
                geminiResponseModel.usageMetadata?.promptTokenCount ?? 0,
            totalTokenCount:
                geminiResponseModel.usageMetadata?.totalTokenCount ?? 0,
            candidatesTokensDetails: geminiResponseModel
                    .usageMetadata?.candidatesTokensDetails
                    ?.map((e) => TokensDetailAttribute(
                        modality: e.modality ?? "",
                        tokenCount: e.tokenCount ?? 0))
                    .toList() ??
                [],
            promptTokensDetails: geminiResponseModel
                    .usageMetadata?.promptTokensDetails
                    ?.map((e) => TokensDetailAttribute(
                        modality: e.modality ?? "",
                        tokenCount: e.tokenCount ?? 0))
                    .toList() ??
                [],
          ),
        );
        if (geminiAttributeModel.candidates?.isEmpty == true) {
          emit(GeminiEmptyState());
        } else {
          emit(GeminiSuccessState(geminiAttributeModel: geminiAttributeModel));
        }
      }
    } catch (e) {
      emit(GeminiFailureState());
    }
  }
}
