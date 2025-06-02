import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja_com_distancia.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/data/services/location_service.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/cubit/lojas_proximas_state.dart';
import 'package:geolocator/geolocator.dart';

class LojasProximasCubit extends Cubit<LojasProximasState> {
  LojasProximasCubit({
    required this.lojaRepository,
    required this.locationService,
  }) : super(LojasProximasInitial());

  final LojaRepository lojaRepository;
  final LocationService locationService;

  /// Carrega todas as lojas ordenadas por proximidade
  Future<void> carregarLojasProximas({double? raioMaxKm}) async {
    emit(LojasProximasLoading());

    try {
      // Tenta obter a localização do usuário
      final Position? posicao = await locationService.getCurrentLocation();

      if (posicao != null) {
        // Se tiver localização, busca lojas por proximidade
        final lojas = await lojaRepository.getLojasProximas(
          userLat: posicao.latitude,
          userLon: posicao.longitude,
          raioMaxKm: raioMaxKm,
        );

        emit(LojasProximasSuccess(
          lojas: lojas,
          raioMaxKm: raioMaxKm,
          temLocalizacao: true,
        ));
      } else {
        // Se não tiver localização, busca todas as lojas sem ordenação
        final lojas = await lojaRepository.getAllLojas();
        // Converte Loja para LojaComDistancia com distância zero
        final lojasComDistancia =
            lojas.map((loja) => LojaComDistancia.fromLoja(loja, 0.0)).toList();

        emit(LojasProximasSuccess(
          lojas: lojasComDistancia,
          raioMaxKm: null,
          temLocalizacao: false,
        ));
      }
    } catch (e) {
      emit(LojasProximasFailure('Erro ao carregar lojas: $e'));
    }
  }

  /// Atualiza o raio máximo de busca
  Future<void> atualizarRaioMaximo(double? raioMaxKm) async {
    final currentState = state;
    if (currentState is LojasProximasSuccess && currentState.temLocalizacao) {
      emit(LojasProximasLoading());
      try {
        // Obtém a localização atual novamente
        final Position? posicao = await locationService.getCurrentLocation();

        if (posicao != null) {
          // Busca lojas com o novo raio
          final lojas = await lojaRepository.getLojasProximas(
            userLat: posicao.latitude,
            userLon: posicao.longitude,
            raioMaxKm: raioMaxKm,
          );

          emit(LojasProximasSuccess(
            lojas: lojas,
            raioMaxKm: raioMaxKm,
            temLocalizacao: true,
          ));
        } else {
          // Se perdeu a localização, volta para o estado anterior
          emit(currentState);
        }
      } catch (e) {
        emit(LojasProximasFailure('Erro ao atualizar raio: $e'));
      }
    }
  }

  /// Solicita permissão de localização e recarrega as lojas
  Future<void> solicitarPermissaoERecarregar() async {
    final permissionGranted = await locationService.requestLocationPermission();
    if (permissionGranted) {
      await carregarLojasProximas(
        raioMaxKm: state is LojasProximasSuccess
            ? (state as LojasProximasSuccess).raioMaxKm
            : null,
      );
    }
  }
}
