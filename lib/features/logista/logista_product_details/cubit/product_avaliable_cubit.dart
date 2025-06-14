import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_avaliable_state.dart';

class ProductAvaliableCubit extends Cubit<ProductAvaliableState> {
  ProductAvaliableCubit(this._repository) : super(ProductAvaliableInitial());

  final ILojistaRepository _repository;

  Future<void> toggleVisibility(
    String productId,
    String lojaId,
    String profileId,
    // ignore: avoid_positional_boolean_parameters
    bool previusVisibity,
  ) async {
    try {
      final result = await _repository.toggleVisibility(
        productId,
        lojaId,
        profileId,
        previusVisibity: previusVisibity,
      );

      emit(ProductAvaliableSuccess(visibility: result));
    } on Exception catch (e) {
      log(e.toString());
      emit(
        const ProductAvaliableFailure(
          'Ocorreu um erro desconhecido ao alterar a visibilidade',
        ),
      );
    }
  }
}
