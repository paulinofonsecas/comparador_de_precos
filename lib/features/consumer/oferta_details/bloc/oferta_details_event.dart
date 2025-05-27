part of 'oferta_details_bloc.dart';

abstract class OfertaDetailsEvent  extends Equatable {
  const OfertaDetailsEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_oferta_details_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomOfertaDetailsEvent extends OfertaDetailsEvent {
  /// {@macro custom_oferta_details_event}
  const CustomOfertaDetailsEvent();
}
