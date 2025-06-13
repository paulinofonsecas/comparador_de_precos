part of 'get_all_products_cubit.dart';

sealed class GetAllProductsState extends Equatable {
  const GetAllProductsState(this.produtos);

  final List<Produto> produtos;

  @override
  List<Object> get props => [];
}

final class GetAllProductsInitial extends GetAllProductsState {
  const GetAllProductsInitial() : super(const []);

  @override
  List<Object> get props => [];
}

final class GetAllProductsLoading extends GetAllProductsState {
  const GetAllProductsLoading() : super(const []);

  @override
  List<Object> get props => [];
}

final class GetAllProductsSuccess extends GetAllProductsState {
  const GetAllProductsSuccess(super.produtos);

  @override
  List<Object> get props => [produtos];
}

final class GetAllProductsFailure extends GetAllProductsState {
  const GetAllProductsFailure(this.message) : super(const []);

  final String message;

  @override
  List<Object> get props => [message];
}
