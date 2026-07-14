import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/utils/flag_url.dart';

class FlagImage extends StatelessWidget {
  const FlagImage({super.key, required this.countryCode, required this.label, this.width = 72, this.height = 48});
  final String countryCode;
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Semantics(
        image: true,
        label: '$label flag',
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3), width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.5),
            child: CachedNetworkImage(
              imageUrl: flagUrl(countryCode),
              width: width,
              height: height,
              fit: BoxFit.cover,
              placeholder: (context, url) => ColoredBox(color: Theme.of(context).colorScheme.surfaceContainerHighest),
              errorWidget: (context, url, error) => ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Center(child: Text('🏳️', style: TextStyle(fontSize: height * .48))),
              ),
            ),
          ),
        ),
      );
}
