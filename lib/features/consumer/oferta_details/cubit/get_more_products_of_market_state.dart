part of 'get_more_products_of_market_cubit.dart';

sealed class GetMoreProductsOfMarketState extends Equatable {
  const GetMoreProductsOfMarketState();

  @override
  List<Object> get props => [];
}

final class GetMoreProductsOfMarketInitial
    extends GetMoreProductsOfMarketState {}

final class GetMoreProductsOfMarketLoading
    extends GetMoreProductsOfMarketState {}

final class GetMoreProductsOfMarketSuccess
    extends GetMoreProductsOfMarketState {
  const GetMoreProductsOfMarketSuccess({required this.produtos});

  final List<Produto> produtos;

  @override
  List<Object> get props => [produtos];
}

final class GetMoreProductsOfMarketFailure
    extends GetMoreProductsOfMarketState {
  const GetMoreProductsOfMarketFailure({required this.error});

  final String error;
}
