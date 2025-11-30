import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_lojistas_state.dart';

class GetLojistasCubit extends Cubit<GetLojistasState> {
  GetLojistasCubit(this._lojistaRepository) : super(GetLojistasInitial());

  final SupabaseLojistaRepository _lojistaRepository;

  Future<List<UserProfile>> getLojistas(String search) async {
    try {
      final lojistas = await _lojistaRepository.getLojistas(search);

      if (lojistas.isEmpty) {
        return [];
      } else {
        return lojistas;
      }
    } catch (e) {
      return [];
    }
  }
}
