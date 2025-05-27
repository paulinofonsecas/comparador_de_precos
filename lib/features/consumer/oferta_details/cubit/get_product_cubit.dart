import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit(this.repository) : super(GetProductInitial());

  final ProductCatalogRepository repository;

  Future<void> getProduct(String id) async {
    emit(GetProductLoading());
    try {
      final produto = await repository.getProdutoById(id);
      emit(GetProductSuccess(produto: produto));
    } catch (e) {
      emit(GetProductError(message: e.toString()));
    }
  }
}
