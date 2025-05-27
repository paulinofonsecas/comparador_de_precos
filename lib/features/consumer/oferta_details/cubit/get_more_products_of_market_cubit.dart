import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_more_products_of_market_state.dart';

class GetMoreProductsOfMarketCubit extends Cubit<GetMoreProductsOfMarketState> {
  GetMoreProductsOfMarketCubit(this.productCatalogRepository)
      : super(GetMoreProductsOfMarketInitial());

  final ProductCatalogRepository productCatalogRepository;

  Future<void> getMoreProductsOfMarket(String marketId) async {
    emit(GetMoreProductsOfMarketLoading());
    try {
      final produtos = await productCatalogRepository.getProductsByMarketId(
        marketId: marketId,
      );
      emit(GetMoreProductsOfMarketSuccess(produtos: produtos));
    } catch (e) {
      emit(GetMoreProductsOfMarketFailure(error: e.toString()));
    }
  }
}
