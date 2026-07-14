import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/logo.png', width: 32, height: 32, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Explore Countries',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22, height: 1.1, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Search a country or code'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _CapsuleChip(label: 'All', isSelected: _continent == null, onTap: () => setState(() => _continent = null)),
                const SizedBox(width: 8),
                ..._continents.expand((continent) => [
                      _CapsuleChip(label: continent, isSelected: _continent == continent, onTap: () => setState(() => _continent = _continent == continent ? null : continent)),
                      const SizedBox(width: 8),
                    ]),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
                            padding: const EdgeInsets.fromLTRB(24, 4, 24, 120),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: constraints.maxWidth >= 1080 ? 3 : 2, childAspectRatio: 3.25, crossAxisSpacing: 16, mainAxisSpacing: 16),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) => _card(context, filtered[index], favoriteCodes),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(24, 4, 24, 120),
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) => _card(context, filtered[index], favoriteCodes),
                          );
                  }),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _card(BuildContext context, Country country, Set<String> favoriteCodes) => CountryCard(
        country: country,
        isFavorite: favoriteCodes.contains(country.code),
        onTap: () => context.push('/country/${country.code}', extra: country),
        onFavoritePressed: () => ref.read(favoritesProvider.notifier).toggle(country),
      );
}

class _CapsuleChip extends StatelessWidget {
  const _CapsuleChip({required this.label, required this.isSelected, required this.onTap});
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent, width: 1),
          boxShadow: isSelected ? [BoxShadow(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
        ),
      ),
    );
  }
}


