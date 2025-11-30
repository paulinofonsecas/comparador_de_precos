import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'all_users_state.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  AllUsersCubit(this._authRepository) : super(AllUsersInitial());

  final IAuthenticationRepository _authRepository;

  Future<void> getAllUsers() async {
    emit(AllUsersLoading());
    try {
      final users = await _authRepository.getAllUsers();

      emit(AllUsersLoaded(users: users));
    } catch (e) {
      emit(
        const AllUsersError(
          message: 'Ocorreu um erro ao carregar os usuários.',
        ),
      );
    }
  }
}
