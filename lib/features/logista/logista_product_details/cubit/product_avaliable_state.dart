part of 'product_avaliable_cubit.dart';

sealed class ProductAvaliableState extends Equatable {
  const ProductAvaliableState();

  @override
  List<Object> get props => [];
}

final class ProductAvaliableInitial extends ProductAvaliableState {}

final class ProductAvaliableLoading extends ProductAvaliableState {}

final class ProductAvaliableSuccess extends ProductAvaliableState {
  const ProductAvaliableSuccess({required this.visibility});

  final bool visibility;

  @override
  List<Object> get props => [visibility];
}

class ProductAvaliableFailure extends ProductAvaliableState {
  const ProductAvaliableFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
