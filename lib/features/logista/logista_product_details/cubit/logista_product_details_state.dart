part of 'logista_product_details_cubit.dart';

/// {@template logista_product_details}
/// LogistaProductDetailsState description
/// {@endtemplate}
class LogistaProductDetailsState extends Equatable {
  /// {@macro logista_product_details}
  const LogistaProductDetailsState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current LogistaProductDetailsState with property changes
  LogistaProductDetailsState copyWith({
    String? customProperty,
  }) {
    return LogistaProductDetailsState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template logista_product_details_initial}
/// The initial state of LogistaProductDetailsState
/// {@endtemplate}
class LogistaProductDetailsInitial extends LogistaProductDetailsState {
  /// {@macro logista_product_details_initial}
  const LogistaProductDetailsInitial() : super();
}

class LogistaProductDetailsLoading extends LogistaProductDetailsState {}

class LogistaProductDetailsLoaded extends LogistaProductDetailsState {
  const LogistaProductDetailsLoaded(this.produto);

  final ProductWithPrice produto;

  @override
  List<Object> get props => [produto];
}

class LogistaProductDetailsError extends LogistaProductDetailsState {
  const LogistaProductDetailsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
