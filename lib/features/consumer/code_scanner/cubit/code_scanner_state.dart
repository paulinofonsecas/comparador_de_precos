part of 'code_scanner_cubit.dart';

/// {@template code_scanner}
/// CodeScannerState description
/// {@endtemplate}
class CodeScannerState extends Equatable {
  /// {@macro code_scanner}
  const CodeScannerState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current CodeScannerState with property changes
  CodeScannerState copyWith({
    String? customProperty,
  }) {
    return CodeScannerState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}
/// {@template code_scanner_initial}
/// The initial state of CodeScannerState
/// {@endtemplate}
class CodeScannerInitial extends CodeScannerState {
  /// {@macro code_scanner_initial}
  const CodeScannerInitial() : super();
}
