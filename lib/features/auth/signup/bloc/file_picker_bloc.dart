import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'file_picker_event.dart';
part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  FilePickerBloc() : super(const FilePickerState()) {
    on<PickFilesEvent>(_onPickFiles);
    on<RemoveFileEvent>(_onRemoveFile);
  }

  Future<void> _onPickFiles(
      PickFilesEvent event, Emitter<FilePickerState> emit) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );

    if (result != null) {
      final files =
          result.files.where((f) => f.size <= 1024 * 1024).take(5).toList();
      emit(state.copyWith(files: files));
    }
  }

  void _onRemoveFile(RemoveFileEvent event, Emitter<FilePickerState> emit) {
    final updated = List.of(state.files)..removeAt(event.index);
    emit(state.copyWith(files: updated));
  }
}
