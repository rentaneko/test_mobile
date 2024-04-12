import 'dart:convert';
import 'package:vietravel/core/models/country.model.dart';
import 'package:vietravel/core/repository/api/api_service.dart';

class ApiRepo {
  final ApiService _apiService;

  ApiRepo({required ApiService apiService}) : _apiService = apiService;

  Future<List<Country>> getListCountry() async {
    List<Country> countries = [];
    await _apiService.getListCountry().then((value) {
      countries = (jsonDecode(value!)['articles'] as List)
          .map((e) => Country.fromJson(e))
          .toList();
    });
    return countries;
  }

  Future<List<Country>?> searchByName({required String keyword}) async {
    List<Country> countries = [];
    await _apiService.searchCountry(keyword: keyword).then((value) {
      countries = (jsonDecode(value!)['articles'] as List)
          .map((e) => Country.fromJson(e))
          .toList();
    });
    return countries;
  }
}
