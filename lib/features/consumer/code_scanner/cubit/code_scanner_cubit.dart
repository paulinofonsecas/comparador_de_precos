import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'code_scanner_state.dart';

class CodeScannerCubit extends Cubit<CodeScannerState> {
  CodeScannerCubit() : super(const CodeScannerInitial());

  /// A description for yourCustomFunction 
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
