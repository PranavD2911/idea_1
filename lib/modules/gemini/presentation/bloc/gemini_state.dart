part of 'gemini_bloc.dart';

sealed class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

final class GeminiInitial extends GeminiState {}

final class GeminiLoadingState extends GeminiState {}

final class GeminiSuccessState extends GeminiState {
  final GeminiAttributeModel geminiAttributeModel;
  const GeminiSuccessState({required this.geminiAttributeModel});
  @override
  List<Object> get props => [geminiAttributeModel];
}

final class GeminiFailureState extends GeminiState {}

final class GeminiEmptyState extends GeminiState {}
