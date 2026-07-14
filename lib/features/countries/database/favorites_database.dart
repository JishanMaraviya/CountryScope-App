import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/country.dart';

class FavoritesDatabase {
  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    final directory = await getApplicationDocumentsDirectory();
    _database = await openDatabase(
      path.join(directory.path, 'countries_explorer.db'),
      version: 1,
      onCreate: (database, version) => database.execute(
        'CREATE TABLE favorites (code TEXT PRIMARY KEY, country_json TEXT NOT NULL)',
      ),
    );
    return _database!;
  }

  Future<Set<String>> codes() async => (await (await _db).query('favorites', columns: ['code']))
      .map((row) => row['code'] as String)
      .toSet();

  Future<List<Country>> all() async => (await (await _db).query('favorites', orderBy: 'code ASC'))
      .map((row) => Country.fromJson(jsonDecode(row['country_json'] as String) as Map<String, dynamic>))
      .toList(growable: false);

  Future<void> save(Country country) async => (await _db).insert(
        'favorites',
        {'code': country.code, 'country_json': jsonEncode(country.toJson())},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  Future<void> remove(String code) async => (await _db).delete('favorites', where: 'code = ?', whereArgs: [code]);
}
