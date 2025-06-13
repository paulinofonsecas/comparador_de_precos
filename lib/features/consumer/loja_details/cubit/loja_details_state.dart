part of 'loja_details_cubit.dart';

abstract class LojaDetailsState extends Equatable {
  const LojaDetailsState();

  @override
  List<Object> get props => [];
}

class LojaDetailsInitial extends LojaDetailsState {}

class LojaDetailsLoading extends LojaDetailsState {}

class LojaDetailsSuccess extends LojaDetailsState {
  const LojaDetailsSuccess(this.loja);
  final Loja loja;

  @override
  List<Object> get props => [loja];
}

class LojaDetailsFailure extends LojaDetailsState {

  const LojaDetailsFailure(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
