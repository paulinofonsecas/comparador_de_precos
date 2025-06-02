part of 'loja_details_cubit.dart';

abstract class LojaDetailsState extends Equatable {
  const LojaDetailsState();

  @override
  List<Object> get props => [];
}

class LojaDetailsInitial extends LojaDetailsState {}

class LojaDetailsLoading extends LojaDetailsState {}

class LojaDetailsSuccess extends LojaDetailsState {
  final Loja loja;
  const LojaDetailsSuccess(this.loja);

  @override
  List<Object> get props => [loja];
}

class LojaDetailsFailure extends LojaDetailsState {
  final String error;

  const LojaDetailsFailure(this.error);

  @override
  List<Object> get props => [error];
}
