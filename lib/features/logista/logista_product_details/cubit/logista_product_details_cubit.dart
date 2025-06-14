import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:equatable/equatable.dart';
part 'logista_product_details_state.dart';

class LogistaProductDetailsCubit extends Cubit<LogistaProductDetailsState> {
  LogistaProductDetailsCubit({
    required this.produtoId,
    required this.logistaId,
    required this.logistaRepository,
  }) : super(const LogistaProductDetailsInitial());

  final String produtoId;
  final String logistaId;

  final ILojistaRepository logistaRepository;

  /// A description for yourCustomFunction
  FutureOr<void> getProdutoDetails(String produtoId) async {
    emit(LogistaProductDetailsLoading());
    try {
      final produto = await logistaRepository.getProdutosAssociado(
        produtoId,
        logistaId,
      );

      if (produto == null) {
        emit(LogistaProductDetailsError('Produto não encontrado'));
      } else {
        emit(LogistaProductDetailsLoaded(produto));
      }
    } on Exception catch (e) {
      emit(LogistaProductDetailsError(e.toString()));
    }
  }
}
