import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit(this._repository) : super(const GetAllProductsInitial());

  final ProductCatalogRepository _repository;

  Future<void> fetchAllProducts() async {
    try {
      emit(const GetAllProductsLoading());
      
      final products = await _repository.getAllProducts();

      emit(GetAllProductsSuccess(products));
    } catch (e) {
      emit(GetAllProductsFailure('Failed to fetch products: $e'));
    }
  }
}
