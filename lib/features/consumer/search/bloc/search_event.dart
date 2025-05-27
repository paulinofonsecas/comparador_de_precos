part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class CustomSearchEvent extends SearchEvent {
  const CustomSearchEvent();
}

class SearchProductEvent extends SearchEvent {
  const SearchProductEvent(this.searchText);

  final String searchText;

  @override
  List<Object> get props => [searchText];
}
