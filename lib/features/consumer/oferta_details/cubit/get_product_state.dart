part of 'get_product_cubit.dart';

sealed class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

final class GetProductInitial extends GetProductState {}

final class GetProductLoading extends GetProductState {}

class GetProductSuccess extends GetProductState {
  const GetProductSuccess({required this.produto});

  final Produto produto;

  @override
  List<Object> get props => [produto];
}

final class GetProductError extends GetProductState {
  const GetProductError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
