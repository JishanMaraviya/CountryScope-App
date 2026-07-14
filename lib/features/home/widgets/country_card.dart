import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../features/countries/models/country.dart';
import '../../../shared/widgets/flag_image.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country, required this.isFavorite, required this.onTap, required this.onFavoritePressed});
  final Country country;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: 'View details for ${country.name}',
        child: Card(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                Hero(tag: 'flag-${country.code}', child: FlagImage(countryCode: country.code, label: country.name)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(country.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(country.capital ?? 'No capital listed', maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text('${country.continent.name}  •  ${country.currency ?? '—'}', maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  ]),
                ),
                IconButton(
                  tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                  onPressed: onFavoritePressed,
                  icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isFavorite ? Theme.of(context).colorScheme.error : null),
                ).animate(target: isFavorite ? 1 : 0).scale(begin: const Offset(.8, .8), end: const Offset(1, 1), duration: 220.ms),
              ]),
            ),
          ),
        ),
      );
}
