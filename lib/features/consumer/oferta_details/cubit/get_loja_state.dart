part of 'get_loja_cubit.dart';

sealed class GetLojaState extends Equatable {
  const GetLojaState();

  @override
  List<Object> get props => [];
}

final class GetLojaInitial extends GetLojaState {}

final class GetLojaLoading extends GetLojaState {}

final class GetLojaSuccess extends GetLojaState {
  const GetLojaSuccess(this.loja);

  final Loja loja;

  @override
  List<Object> get props => [loja];
}

final class GetLojaFailure extends GetLojaState {
  const GetLojaFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
