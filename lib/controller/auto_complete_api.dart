import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryAutoComplete {
  Future<List<String>> getCountries(String name) async {
    final client = http.Client();

    return await client
        .get('https://restcountries.eu/rest/v2/name/'+ name + '?fields=name')
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return [];
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) => m['name'] as String).toList();
      }
    });
  }

  Future<List<String>> getLanguages(String name) async {
    final client = http.Client();

    return await client
        .get('https://restcountries.eu/rest/v2/name/'+ name + '?fields=languages')
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return [];
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) {
          List l = json.decode(m['languages']) as List;
          List<LanguagesData> d = l.map((e) => e as LanguagesData).toList();
          return d[0].name;
        }).toList();
      }
    });
  }
}

class LanguagesData {
  String iso639_1;
  String iso639_2;
  String name;
  String nativeName;

  LanguagesData(this.iso639_1, this.iso639_2, this.name, this.nativeName);


}
