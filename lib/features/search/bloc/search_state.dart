part of 'search_bloc.dart';

class SearchState {}

class InititalSearchState extends SearchState {}

class LoadingSearchState extends SearchState {}

class SuccesSearchState extends SearchState {
  final List<Country>? countries;

  SuccesSearchState(this.countries);
}

class ErrorSearchState extends SearchState {
  final String errorMsg;

  ErrorSearchState(this.errorMsg);
}
