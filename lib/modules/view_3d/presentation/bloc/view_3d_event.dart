part of 'view_3d_bloc.dart';

abstract class View3DEvent extends Equatable {
  const View3DEvent();

  @override
  List<Object> get props => [];
}

class PickModelEvent extends View3DEvent {}
