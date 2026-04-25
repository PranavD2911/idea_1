part of 'view_3d_bloc.dart';

abstract class View3DState extends Equatable {
  const View3DState();
  
  @override
  List<Object?> get props => [];
}

class View3DInitial extends View3DState {}

class View3DLoading extends View3DState {}

class View3DLoaded extends View3DState {
  final String filePath;

  const View3DLoaded(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class View3DError extends View3DState {
  final String errorMessage;

  const View3DError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
