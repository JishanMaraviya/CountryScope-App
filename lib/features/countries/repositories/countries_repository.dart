import '../models/country.dart';
import '../services/countries_graphql_service.dart';

class CountriesRepository {
  const CountriesRepository(this._service);
  final CountriesGraphqlService _service;

  Future<List<Country>> getCountries({bool forceNetwork = false}) async {
    final countries = await _service.fetchCountries(forceNetwork: forceNetwork);
    final result = countries.map(Country.fromJson).toList()..sort((a, b) => a.name.compareTo(b.name));
    return result;
  }
}
