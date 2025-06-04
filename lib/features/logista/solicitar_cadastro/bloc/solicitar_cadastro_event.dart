part of 'solicitar_cadastro_bloc.dart';

abstract class SolicitarCadastroEvent  extends Equatable {
  const SolicitarCadastroEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_solicitar_cadastro_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomSolicitarCadastroEvent extends SolicitarCadastroEvent {
  /// {@macro custom_solicitar_cadastro_event}
  const CustomSolicitarCadastroEvent();
}
