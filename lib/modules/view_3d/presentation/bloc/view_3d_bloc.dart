
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import '../utils/blob_helper.dart';

part 'view_3d_event.dart';
part 'view_3d_state.dart';

class View3DBloc extends Bloc<View3DEvent, View3DState> {
  View3DBloc() : super(View3DInitial()) {
    on<PickModelEvent>(_onPickModel);
  }

  Future<void> _onPickModel(PickModelEvent event, Emitter<View3DState> emit) async {
    try {
      emit(View3DLoading());
      
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['glb', 'gltf'],
        withData: kIsWeb, // Force getting bytes on Web
      );

      if (result != null) {
        String filePath;
        
        if (kIsWeb) {
          if (result.files.single.bytes != null) {
            filePath = createBlobUrl(result.files.single.bytes!);
          } else {
            emit(const View3DError('Failed to read file bytes on Web.'));
            return;
          }
        } else {
          final path = result.files.single.path;
          if (path != null) {
            filePath = path;
          } else {
            emit(const View3DError('Invalid file path.'));
            return;
          }
        }
        
        emit(View3DLoaded(filePath));
      } else {
        // User canceled the picker
        emit(View3DInitial());
      }
    } catch (e) {
      emit(View3DError('Failed to pick file: $e'));
    }
  }
}
