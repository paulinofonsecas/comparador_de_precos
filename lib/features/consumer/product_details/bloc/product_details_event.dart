part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_product_details_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomProductDetailsEvent extends ProductDetailsEvent {
  /// {@macro custom_product_details_event}
  const CustomProductDetailsEvent();
}

class LoadProductDetailsEvent extends ProductDetailsEvent {
  const LoadProductDetailsEvent(this.productId);

  final String productId;

  @override
  List<Object> get props => [productId];
}
