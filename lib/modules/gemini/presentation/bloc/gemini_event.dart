part of 'gemini_bloc.dart';

sealed class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object> get props => [];
}

final class GeminiRequestEvent extends GeminiEvent {
  final GeminiRequestModel geminiRequestModel;
  const GeminiRequestEvent({required this.geminiRequestModel});

  @override
  List<Object> get props => [geminiRequestModel];
}
