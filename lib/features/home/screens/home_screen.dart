import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../countries/models/country.dart';
import '../../countries/providers/countries_providers.dart';
import '../../../shared/widgets/state_views.dart';
import '../widgets/country_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _query = '';
  String? _continent;
  static const _continents = ['Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania', 'Antarctica'];

  List<Country> _filtered(List<Country> countries) => countries.where((country) {
        final matchesQuery = country.name.toLowerCase().contains(_query.trim().toLowerCase()) || country.code.toLowerCase().contains(_query.trim().toLowerCase());
        return matchesQuery && (_continent == null || country.continent.name == _continent);
      }).toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final countries = ref.watch(countriesProvider);
    final favoriteCodes = ref.watch(favoritesProvider).valueOrNull ?? const <String>{};
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore countries'),
        actions: [
          IconButton(tooltip: 'Favorites', onPressed: () => context.push('/favorites'), icon: const Icon(Icons.favorite_outline_rounded)),
          IconButton(tooltip: 'Settings', onPressed: () => context.push('/settings'), icon: const Icon(Icons.tune_rounded)),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: TextField(
            onChanged: (value) => setState(() => _query = value),
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Search a country or code'),
          ),
        ),
        SizedBox(
          height: 46,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              FilterChip(label: const Text('All'), selected: _continent == null, onSelected: (_) => setState(() => _continent = null)),
              const SizedBox(width: 8),
              ..._continents.expand((continent) => [
                    FilterChip(label: Text(continent), selected: _continent == continent, onSelected: (_) => setState(() => _continent = _continent == continent ? null : continent)),
                    const SizedBox(width: 8),
                  ]),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: countries.when(
            loading: () => const LoadingCountriesView(),
            error: (error, _) => ErrorStateView(error: error, onRetry: () => ref.read(countriesProvider.notifier).refresh()),
            data: (items) {
              final filtered = _filtered(items);
              if (filtered.isEmpty) return const EmptyStateView(icon: Icons.travel_explore_rounded, title: 'No countries found', message: 'Try a different name or clear your continent filter.');
              return RefreshIndicator(
                onRefresh: () => ref.read(countriesProvider.notifier).refresh(),
                child: LayoutBuilder(builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 760;
                  return wide
                      ? GridView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: constraints.maxWidth >= 1080 ? 3 : 2, childAspectRatio: 3.25, crossAxisSpacing: 12, mainAxisSpacing: 12),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) => _card(context, filtered[index], favoriteCodes),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) => _card(context, filtered[index], favoriteCodes),
                        );
                }),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _card(BuildContext context, Country country, Set<String> favoriteCodes) => CountryCard(
        country: country,
        isFavorite: favoriteCodes.contains(country.code),
        onTap: () => context.push('/country/${country.code}', extra: country),
        onFavoritePressed: () => ref.read(favoritesProvider.notifier).toggle(country),
      );
}
