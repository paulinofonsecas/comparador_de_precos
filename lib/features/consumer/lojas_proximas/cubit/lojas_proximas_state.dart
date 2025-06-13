import 'package:comparador_de_precos/data/models/loja_com_distancia.dart';
import 'package:equatable/equatable.dart';

sealed class LojasProximasState extends Equatable {
  const LojasProximasState();

  @override
  List<Object?> get props => [];
}

final class LojasProximasInitial extends LojasProximasState {}

final class LojasProximasLoading extends LojasProximasState {}

final class LojasProximasSuccess extends LojasProximasState {
  const LojasProximasSuccess({
    required this.lojas,
    this.raioMaxKm,
    required this.temLocalizacao,
  });

  final List<LojaComDistancia> lojas;
  final double? raioMaxKm;
  final bool temLocalizacao;

  @override
  List<Object?> get props => [lojas, raioMaxKm, temLocalizacao];

  LojasProximasSuccess copyWith({
    List<LojaComDistancia>? lojas,
    double? raioMaxKm,
    bool? temLocalizacao,
  }) {
    return LojasProximasSuccess(
      lojas: lojas ?? this.lojas,
      raioMaxKm: raioMaxKm ?? this.raioMaxKm,
      temLocalizacao: temLocalizacao ?? this.temLocalizacao,
    );
  }
}

final class LojasProximasFailure extends LojasProximasState {
  const LojasProximasFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
