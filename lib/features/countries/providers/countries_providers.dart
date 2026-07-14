import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/graphql/app_graphql_client.dart';
import '../database/favorites_database.dart';
import '../models/country.dart';
import '../repositories/countries_repository.dart';
import '../repositories/favorites_repository.dart';
import '../services/countries_graphql_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw StateError('SharedPreferences must be initialized in main.'));

final graphQLClientProvider = Provider<GraphQLClient>((ref) => createGraphqlClient());

final countriesRepositoryProvider = Provider<CountriesRepository>((ref) => CountriesRepository(
      CountriesGraphqlService(ref.watch(graphQLClientProvider)),
    ));

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) => FavoritesRepository(FavoritesDatabase()));

final countriesProvider = AsyncNotifierProvider<CountriesController, List<Country>>(CountriesController.new);

class CountriesController extends AsyncNotifier<List<Country>> {
  @override
  Future<List<Country>> build() => ref.read(countriesRepositoryProvider).getCountries();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(countriesRepositoryProvider).getCountries(forceNetwork: true));
  }
}

final favoritesProvider = AsyncNotifierProvider<FavoritesController, Set<String>>(FavoritesController.new);

class FavoritesController extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() => ref.read(favoritesRepositoryProvider).favoriteCodes();

  Future<void> toggle(Country country) async {
    final previous = state.valueOrNull ?? <String>{};
    final updated = {...previous};
    if (updated.remove(country.code)) {
      await ref.read(favoritesRepositoryProvider).remove(country.code);
    } else {
      updated.add(country.code);
      await ref.read(favoritesRepositoryProvider).add(country);
    }
    state = AsyncData(updated);
  }
}

final favoriteCountriesProvider = FutureProvider<List<Country>>((ref) async {
  ref.watch(favoritesProvider);
  return ref.read(favoritesRepositoryProvider).favorites();
});

final themeModeProvider = AsyncNotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);

class ThemeModeController extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final saved = ref.read(sharedPreferencesProvider).getString(AppConstants.themePreferenceKey);
    return ThemeMode.values.firstWhere((mode) => mode.name == saved, orElse: () => ThemeMode.system);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await ref.read(sharedPreferencesProvider).setString(AppConstants.themePreferenceKey, mode.name);
    state = AsyncData(mode);
  }
}
