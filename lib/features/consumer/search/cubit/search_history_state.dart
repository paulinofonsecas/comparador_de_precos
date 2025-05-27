part of 'search_history_cubit.dart';

sealed class SearchHistoryState extends Equatable {
  const SearchHistoryState();

  @override
  List<Object> get props => [];
}

final class SearchHistoryInitial extends SearchHistoryState {}

final class SearchHistorySuccess extends SearchHistoryState {
  const SearchHistorySuccess(this.history);

  final List<String> history;

  @override
  List<Object> get props => [history];
}

final class SearchHistoryError extends SearchHistoryState {
  const SearchHistoryError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class SearchHistoryRemovedItem extends SearchHistoryState {}
