part of 'aprovar_loja_cubit.dart';

sealed class AprovarLojaState extends Equatable {
  const AprovarLojaState();

  @override
  List<Object> get props => [];
}

final class AprovarLojaInitial extends AprovarLojaState {}

final class AprovarLojaLoading extends AprovarLojaState {}

final class AprovarLojaSuccess extends AprovarLojaState {}

final class AprovarLojaFailure extends AprovarLojaState {
  const AprovarLojaFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
