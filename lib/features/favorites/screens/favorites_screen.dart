import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../countries/providers/countries_providers.dart';
import '../../home/widgets/country_card.dart';
import '../../../shared/widgets/state_views.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteCountriesProvider);
    final favoriteCodes = ref.watch(favoritesProvider).valueOrNull ?? const <String>{};
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        centerTitle: false,
        titleSpacing: 24,
      ),
      body: favorites.when(
        loading: () => const LoadingCountriesView(),
        error: (error, _) => ErrorStateView(error: error, onRetry: () => ref.invalidate(favoriteCountriesProvider)),
        data: (countries) => countries.isEmpty
            ? const EmptyStateView(icon: Icons.favorite_border_rounded, title: 'No favorites yet', message: 'Save countries here for quick offline access.')
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                itemCount: countries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return CountryCard(
                    country: country,
                    isFavorite: favoriteCodes.contains(country.code),
                    onTap: () => context.push('/country/${country.code}', extra: country),
                    onFavoritePressed: () => ref.read(favoritesProvider.notifier).toggle(country),
                  );
                },
              ),
      ),
    );
  }
}
