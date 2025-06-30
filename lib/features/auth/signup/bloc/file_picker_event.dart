part of 'file_picker_bloc.dart';

abstract class FilePickerEvent extends Equatable {
  const FilePickerEvent();

  @override
  List<Object?> get props => [];
}

class PickFilesEvent extends FilePickerEvent {}

class RemoveFileEvent extends FilePickerEvent {
  final int index;
  const RemoveFileEvent(this.index);

  @override
  List<Object?> get props => [index];
}
