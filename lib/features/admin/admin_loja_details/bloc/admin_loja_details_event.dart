part of 'admin_loja_details_bloc.dart';

abstract class AdminLojaDetailsEvent extends Equatable {
  const AdminLojaDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadAdminLojaDetailsEvent extends AdminLojaDetailsEvent {
  /// {@macro load_admin_loja_details_event}
  const LoadAdminLojaDetailsEvent({required this.lojaId});

  /// The ID of the store to load details for
  final String lojaId;

  @override
  List<Object> get props => [lojaId];
}

class AdminLojaDetailsAlterarLojistaEvent extends AdminLojaDetailsEvent {
  /// {@macro admin_loja_details_alterar_lojista_event}
  const AdminLojaDetailsAlterarLojistaEvent({
    required this.lojaId,
    required this.novoLojistaId,
  });

  /// The ID of the store to update
  final String lojaId;

  /// The new lojista to set for the store
  final String novoLojistaId;

  @override
  List<Object> get props => [lojaId, novoLojistaId];
}
