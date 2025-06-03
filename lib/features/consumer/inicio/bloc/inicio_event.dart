part of 'inicio_bloc.dart';

abstract class InicioEvent extends Equatable {
  const InicioEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_lojas_para_voce_event}
/// Event added when the 'Para você' lojas need to be loaded
/// {@endtemplate}
class LoadLojasParaVoceEvent extends InicioEvent {
  /// {@macro load_lojas_para_voce_event}
  const LoadLojasParaVoceEvent();
}
