import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'admin_get_lojas_state.dart';

class AdminGetLojasCubit extends Cubit<AdminGetLojasState> {
  AdminGetLojasCubit(this.lojaRepository) : super(AdminGetLojasInitial());

  final LojaRepository lojaRepository;

  // Fetch initial list of stores
  Future<void> fetchLojas() async {
    try {
      emit(AdminGetLojasLoading());
      final lojas = await lojaRepository.getLojas();
      emit(AdminGetLojasPaginatedSuccess(lojas));
    } catch (e) {
      emit(AdminGetLojasFailure('Failed to fetch stores: $e'));
    }
  }

  // paginate through stores
  Future<void> paginateLojas(int page) async {
    try {
      emit(AdminGetLojasLoading());
      final lojas = await lojaRepository.getLojas(page: page);

      if (lojas.isEmpty) {
        emit(AdminGetLojasNoMoreData());
      } else {
        emit(AdminGetLojasPaginatedSuccess(lojas));
      }
    } catch (e) {
      emit(AdminGetLojasFailure('Failed to fetch more stores: $e'));
    }
  }
}
