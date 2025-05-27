part of 'product_details_bloc.dart';

/// {@template product_details_state}
/// ProductDetailsState description
/// {@endtemplate}
class ProductDetailsState extends Equatable {
  /// {@macro product_details_state}
  const ProductDetailsState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ProductDetailsState with property changes
  ProductDetailsState copyWith({
    String? customProperty,
  }) {
    return ProductDetailsState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template product_details_initial}
/// The initial state of ProductDetailsState
/// {@endtemplate}
class ProductDetailsInitial extends ProductDetailsState {
  /// {@macro product_details_initial}
  const ProductDetailsInitial() : super();
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading() : super();
}

class ProductDetailsLoaded extends ProductDetailsState {
  const ProductDetailsLoaded({required this.produto}) : super();

  final Produto produto;

  @override
  List<Object> get props => [produto];
}

class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError({required this.message}) : super();

  final String message;

  @override
  List<Object> get props => [message];
}
