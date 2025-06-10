import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:equatable/equatable.dart';

part 'associante_product_state.dart';

class AssocianteProductCubit extends Cubit<AssocianteProductState> {
  AssocianteProductCubit(this._lojistaRepository) : super(AssocianteProductInitial());

  final ILojistaRepository _lojistaRepository;

  Future<void> associar(
    String productId,
    String lojaId,
    String associanteId,
    double newPrice,
  ) async {
    try {
      emit(AssocianteProductLoading());

      await _lojistaRepository.associarProduto(
        productId: productId,
        lojaId: lojaId,
        associanteId: associanteId,
        newPrice: newPrice,
      );
      
      emit(AssocianteProductSuccess());
    } catch (e) {
      emit(AssocianteProductFailure(e.toString()));
    
  }
}
}
