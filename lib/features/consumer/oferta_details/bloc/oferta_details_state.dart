part of 'oferta_details_bloc.dart';

/// {@template oferta_details_state}
/// OfertaDetailsState description
/// {@endtemplate}
class OfertaDetailsState extends Equatable {
  /// {@macro oferta_details_state}
  const OfertaDetailsState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current OfertaDetailsState with property changes
  OfertaDetailsState copyWith({
    String? customProperty,
  }) {
    return OfertaDetailsState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template oferta_details_initial}
/// The initial state of OfertaDetailsState
/// {@endtemplate}
class OfertaDetailsInitial extends OfertaDetailsState {
  /// {@macro oferta_details_initial}
  const OfertaDetailsInitial() : super();
}
