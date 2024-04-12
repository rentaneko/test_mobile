part of 'search_bloc.dart';

class SearchEvent {}

class SearchEventAction extends SearchEvent {}

class SearchByNameEvent extends SearchEvent {
  final String name;

  SearchByNameEvent({required this.name});
}

class SearchButtonClickedEvent extends SearchEventAction {}
