part of 'inicio_bloc.dart';

/// {@template inicio_state}
/// InicioState description
/// {@endtemplate}
class InicioState extends Equatable {
  /// {@macro inicio_state}
  const InicioState({
    this.status = InicioStatus.initial,
    this.lojasParaVoce = const [],
    this.errorMessage,
  });

  /// The status of the inicio state
  final InicioStatus status;
  
  /// List of lojas for 'Para você' section
  final List<Loja> lojasParaVoce;
  
  /// Error message if any
  final String? errorMessage;

  @override
  List<Object?> get props => [status, lojasParaVoce, errorMessage];

  /// Creates a copy of the current InicioState with property changes
  InicioState copyWith({
    InicioStatus? status,
    List<Loja>? lojasParaVoce,
    String? Function()? errorMessage,
  }) {
    return InicioState(
      status: status ?? this.status,
      lojasParaVoce: lojasParaVoce ?? this.lojasParaVoce,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

/// Status of the inicio state
enum InicioStatus {
  /// Initial state
  initial,
  
  /// Loading data
  loading,
  
  /// Data loaded successfully
  success,
  
  /// Error loading data
  failure,
}

/// {@template inicio_initial}
/// The initial state of InicioState
/// {@endtemplate}
class InicioInitial extends InicioState {
  /// {@macro inicio_initial}
  const InicioInitial() : super();
}
