import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_similar_products_state.dart';

class GetSimilarProductsCubit extends Cubit<GetSimilarProductsState> {
  GetSimilarProductsCubit(this.repository) : super(GetSimilarProductsInitial());

  final ProductCatalogRepository repository;

  Future<void> getSimilarProducts(String productName) async {
    emit(GetSimilarProductsLoading());
    try {
      final similarProducts = await repository.getSimilarProducts(productName);

      emit(GetSimilarProductsSuccess(similarProducts));
    } catch (e) {
      emit(GetSimilarProductsFailure(e.toString()));
    }
  }
}
