import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../countries/models/country.dart';
import '../../countries/providers/countries_providers.dart';
import '../../../shared/widgets/flag_image.dart';

class CountryDetailsScreen extends ConsumerWidget {
  const CountryDetailsScreen({super.key, required this.country});
  final Country country;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).valueOrNull?.contains(country.code) ?? false;
    final isRtl = country.languages.any((language) => language.isRtl);
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(country.name),
          actions: [IconButton(tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites', onPressed: () => ref.read(favoritesProvider.notifier).toggle(country), icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: Hero(tag: 'flag-${country.code}', child: FlagImage(countryCode: country.code, label: country.name, width: 220, height: 145))),
                const SizedBox(height: 20),
                Center(child: Text('${country.emoji}  ${country.name}', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center)),
                const SizedBox(height: 4),
                Center(child: Text(country.nativeName, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))),
                const SizedBox(height: 28),
                _DetailsCard(title: 'At a glance', children: [
                  _DetailRow(icon: Icons.location_city_rounded, label: 'Capital', value: country.capital ?? 'Not listed'),
                  _DetailRow(icon: Icons.public_rounded, label: 'Continent', value: country.continent.name),
                  _DetailRow(icon: Icons.currency_exchange_rounded, label: 'Currency', value: country.currency ?? 'Not listed'),
                  _DetailRow(icon: Icons.phone_rounded, label: 'Phone code', value: country.phone.isEmpty ? 'Not listed' : '+${country.phone}'),
                  _DetailRow(icon: Icons.code_rounded, label: 'Country code', value: country.code),
                ]),
                const SizedBox(height: 16),
                _DetailsCard(
                  title: 'Languages',
                  children: country.languages.isEmpty
                      ? const [_DetailRow(icon: Icons.translate_rounded, label: 'Languages', value: 'Not listed')]
                      : country.languages.map((language) => _DetailRow(icon: Icons.translate_rounded, label: language.name, value: language.nativeName.isEmpty ? language.code : language.nativeName)).toList(),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 10), ...children])));
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 12), Expanded(child: Text(label)), Flexible(child: Text(value, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)))]));
}
