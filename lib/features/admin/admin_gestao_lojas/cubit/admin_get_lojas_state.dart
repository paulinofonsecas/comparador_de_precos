part of 'admin_get_lojas_cubit.dart';

sealed class AdminGetLojasState extends Equatable {
  const AdminGetLojasState();

  @override
  List<Object> get props => [];
}

final class AdminGetLojasInitial extends AdminGetLojasState {}

final class AdminGetLojasLoading extends AdminGetLojasState {}

final class AdminGetLojasPaginatedSuccess extends AdminGetLojasState {
  const AdminGetLojasPaginatedSuccess(this.lojas);
  final List<Loja> lojas;

  @override
  List<Object> get props => [lojas];
}

final class AdminGetLojasNoMoreData extends AdminGetLojasState {}

final class AdminGetLojasFailure extends AdminGetLojasState {
  const AdminGetLojasFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
