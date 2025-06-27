part of 'search_lojas_cubit.dart';

sealed class SearchLojasState extends Equatable {
  const SearchLojasState();

  @override
  List<Object> get props => [];
}

final class SearchLojasInitial extends SearchLojasState {}

final class SearchLojasLoading extends SearchLojasState {}

final class SearchLojasSuccess extends SearchLojasState {
  const SearchLojasSuccess(this.lojas);

  final List<Loja> lojas;

  @override
  List<Object> get props => [lojas];
}

final class SearchLojasFailure extends SearchLojasState {
  const SearchLojasFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
