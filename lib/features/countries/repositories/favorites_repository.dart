import '../database/favorites_database.dart';
import '../models/country.dart';

class FavoritesRepository {
  const FavoritesRepository(this._database);
  final FavoritesDatabase _database;

  Future<Set<String>> favoriteCodes() => _database.codes();
  Future<List<Country>> favorites() => _database.all();
  Future<void> add(Country country) => _database.save(country);
  Future<void> remove(String code) => _database.remove(code);
}
