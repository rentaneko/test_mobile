import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietravel/core/repository/api/api_service.dart';
import 'package:vietravel/core/repository/repo/api_repo.dart';

import '../../../core/models/country.model.dart';
part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(LoadingHomeState()) {
    on<InitialHomeEvent>(initialHomeEvet);
  }

  List<Country> countries = [];
  FutureOr<void> initialHomeEvet(
      InitialHomeEvent event, Emitter<HomeState> emit) async {
    final ApiRepo _apiRepo = ApiRepo(apiService: ApiService());
    emit(LoadingHomeState());

    try {
      countries = await _apiRepo.getListCountry();
      emit(LoadedHomeState(countries));
    } on PlatformException catch (e) {
      emit(ErrorHomeState(e.message!));
    }
  }
}
