import 'package:http/http.dart' as http;
import 'package:vietravel/core/constant/value.dart';

class ApiService {
  Future<String?> getListCountry() async {
    var res = await http.get(
      Uri.parse('$baseUrl/v2/top-headlines?country=us&apiKey=$apiKey'),
    );
    return res.statusCode == 200 ? res.body : null;
  }

  Future<String?> searchCountry({required String keyword}) async {
    var res = await http.get(
      Uri.parse('$baseUrl/v2/everything?q=$keyword&apiKey=$apiKey'),
    );
    return res.statusCode == 200 ? res.body : null;
  }
}
