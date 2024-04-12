part of 'home_bloc.dart';

class HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<Country>? countries;

  LoadedHomeState(this.countries);
}

class ErrorHomeState extends HomeState {
  final String? errorMsg;

  ErrorHomeState(this.errorMsg);
}
