part of 'desaprovar_loja_cubit.dart';

sealed class DesaprovarLojaState extends Equatable {
  const DesaprovarLojaState();

  @override
  List<Object> get props => [];
}

final class DesaprovarLojaInitial extends DesaprovarLojaState {}

final class DesaprovarLojaLoading extends DesaprovarLojaState {}

final class DesaprovarLojaSuccess extends DesaprovarLojaState {}

final class DesaprovarLojaFailure extends DesaprovarLojaState {
  const DesaprovarLojaFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
