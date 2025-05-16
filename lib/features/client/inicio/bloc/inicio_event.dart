part of 'inicio_bloc.dart';

abstract class InicioEvent  extends Equatable {
  const InicioEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_inicio_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomInicioEvent extends InicioEvent {
  /// {@macro custom_inicio_event}
  const CustomInicioEvent();
}
