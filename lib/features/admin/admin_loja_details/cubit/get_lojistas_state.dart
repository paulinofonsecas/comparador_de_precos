part of 'get_lojistas_cubit.dart';

sealed class GetLojistasState extends Equatable {
  const GetLojistasState();

  @override
  List<Object> get props => [];
}

final class GetLojistasInitial extends GetLojistasState {}

final class GetLojistasLoading extends GetLojistasState {}

final class GetLojistasLoaded extends GetLojistasState {
  const GetLojistasLoaded(this.lojistas);

  final List<UserProfile> lojistas;

  @override
  List<Object> get props => [lojistas];
}

final class GetLojistasEmpty extends GetLojistasState {}

final class GetLojistasError extends GetLojistasState {
  const GetLojistasError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
