part of 'get_similar_products_cubit.dart';

sealed class GetSimilarProductsState extends Equatable {
  const GetSimilarProductsState();

  @override
  List<Object> get props => [];
}

final class GetSimilarProductsInitial extends GetSimilarProductsState {}

final class GetSimilarProductsLoading extends GetSimilarProductsState {}

final class GetSimilarProductsSuccess extends GetSimilarProductsState {
  const GetSimilarProductsSuccess(this.similarProducts);

  final List<OfertaModel> similarProducts;

  @override
  List<Object> get props => [similarProducts];
}

final class GetSimilarProductsFailure extends GetSimilarProductsState {
  const GetSimilarProductsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
