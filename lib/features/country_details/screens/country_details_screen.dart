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
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                onPressed: () => ref.read(favoritesProvider.notifier).toggle(country),
                icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isFavorite ? Theme.of(context).colorScheme.error : null),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Hero(
                  tag: 'flag-${country.code}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 30, offset: const Offset(0, 15))],
                    ),
                    child: FlagImage(countryCode: country.code, label: country.name, width: 240, height: 160),
                  ),
                ),
                const SizedBox(height: 32),
                Text(country.name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5), textAlign: TextAlign.center),
                const SizedBox(height: 6),
                Text('${country.emoji}  ${country.nativeName}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500)),
                const SizedBox(height: 40),
                _DetailsGroup(title: 'At a glance', children: [
                  _DetailRow(icon: Icons.location_city_rounded, label: 'Capital', value: country.capital ?? 'Not listed'),
                  _DetailRow(icon: Icons.public_rounded, label: 'Continent', value: country.continent.name),
                  _DetailRow(icon: Icons.currency_exchange_rounded, label: 'Currency', value: country.currency ?? 'Not listed'),
                  _DetailRow(icon: Icons.phone_rounded, label: 'Phone code', value: country.phone.isEmpty ? 'Not listed' : '+${country.phone}'),
                  _DetailRow(icon: Icons.code_rounded, label: 'Country code', value: country.code),
                ]),
                const SizedBox(height: 24),
                _DetailsGroup(
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

class _DetailsGroup extends StatelessWidget {
  const _DetailsGroup({required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(title.toUpperCase(), style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3), width: 1),
            ),
            child: Column(
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i < children.length - 1)
                    Divider(height: 1, indent: 56, endIndent: 0, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)),
                ],
              ],
            ),
          ),
        ],
      );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500))),
          Flexible(child: Text(value, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))),
        ]),
      );
}
