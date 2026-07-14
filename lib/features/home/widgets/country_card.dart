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
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.04), blurRadius: 24, offset: const Offset(0, 8)),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              highlightColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.02),
              splashColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.04),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(tag: 'flag-${country.code}', child: FlagImage(countryCode: country.code, label: country.name, width: 88, height: 60)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                        Text(country.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
                        const SizedBox(height: 4),
                        Text(country.capital ?? 'No capital listed', maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _Badge(text: country.continent.name, icon: Icons.public_rounded),
                            if (country.currency != null) _Badge(text: country.currency!, icon: Icons.payments_rounded),
                          ],
                        ),
                      ]),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                            onPressed: onFavoritePressed,
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                            style: IconButton.styleFrom(elevation: 0, shadowColor: Colors.transparent),
                            icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded, size: 18, color: isFavorite ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ).animate(target: isFavorite ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15), duration: 200.ms, curve: Curves.easeOutBack).then().scale(begin: const Offset(1.15, 1.15), end: const Offset(1, 1), duration: 150.ms),
                        const SizedBox(height: 12),
                        Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.outline, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(text, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
