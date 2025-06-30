part of 'file_picker_bloc.dart';

class FilePickerState extends Equatable {
  final List<PlatformFile> files;
  const FilePickerState({this.files = const []});

  FilePickerState copyWith({List<PlatformFile>? files}) {
    return FilePickerState(files: files ?? this.files);
  }

  @override
  List<Object?> get props => [files];
}
