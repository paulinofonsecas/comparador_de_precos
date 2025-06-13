part of 'logista_produtos_associados_bloc.dart';

abstract class LogistaProdutosAssociadosEvent  extends Equatable {
  const LogistaProdutosAssociadosEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_logista_produtos_associados_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomLogistaProdutosAssociadosEvent extends LogistaProdutosAssociadosEvent {
  /// {@macro custom_logista_produtos_associados_event}
  const CustomLogistaProdutosAssociadosEvent();
}
