import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:equatable/equatable.dart';
part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc({required this.repository})
      : super(const ProductDetailsInitial()) {
    on<CustomProductDetailsEvent>(_onCustomProductDetailsEvent);
    on<LoadProductDetailsEvent>(_onLoadProductDetailsEvent);
  }

  final ProductCatalogRepository repository;

  FutureOr<void> _onCustomProductDetailsEvent(
    CustomProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) {
    // TODO: Add Logic
  }

  FutureOr<void> _onLoadProductDetailsEvent(
    LoadProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(const ProductDetailsLoading());
    try {
      final produto = await repository.getProdutoById(event.productId);
      emit(ProductDetailsLoaded(produto: produto));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }
}
