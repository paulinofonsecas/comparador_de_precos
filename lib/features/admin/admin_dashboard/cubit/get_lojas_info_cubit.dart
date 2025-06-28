import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_lojas_info_state.dart';

class GetLojasInfoCubit extends Cubit<GetLojasInfoState> {
  GetLojasInfoCubit(this._lojaRepository) : super(GetLojasInfoInitial());

  final LojaRepository _lojaRepository;

  Future<void> fetchLojasInfo() async {
    try {
      emit(GetLojasInfoLoading());
      final lojasInfo = await _lojaRepository.getLojasInfo();

      // Aqui você deve buscar as informações reais das lojas
      final response = {
        'totalLojas': lojasInfo['totalLojas'] ?? 0,
        'lojasParaAvaliar': lojasInfo['lojasParaAvaliar'] ?? 0,
      };

      emit(GetLojasInfoSuccess(response));
    } catch (e) {
      emit(const GetLojasInfoFailure('Erro ao carregar informações das lojas'));
    }
  }
}
