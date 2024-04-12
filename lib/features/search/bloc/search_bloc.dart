import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/country.model.dart';
import '../../../core/repository/api/api_service.dart';
import '../../../core/repository/repo/api_repo.dart';
part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InititalSearchState()) {
    on<SearchByNameEvent>(searchByName);
  }

  List<Country>? countries = [];
  FutureOr<void> searchByName(
      SearchByNameEvent event, Emitter<SearchState> emit) async {
    final ApiRepo _apiRepo = ApiRepo(apiService: ApiService());
    emit(LoadingSearchState());

    try {
      countries = await _apiRepo.searchByName(keyword: event.name);
      emit(SuccesSearchState(countries));
    } on PlatformException catch (e) {
      emit(ErrorSearchState(e.message!));
    }
  }
}
