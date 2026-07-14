import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../countries/providers/countries_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        centerTitle: false,
        titleSpacing: 24,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(padding: const EdgeInsets.fromLTRB(24, 8, 24, 120), children: [
        _SettingsGroup(title: 'Appearance', children: [
          _ThemeOption(icon: Icons.light_mode_rounded, title: 'Light', mode: ThemeMode.light, groupValue: mode, color: Colors.amber),
          _ThemeOption(icon: Icons.dark_mode_rounded, title: 'Dark', mode: ThemeMode.dark, groupValue: mode, color: Colors.indigo),
          _ThemeOption(icon: Icons.brightness_auto_rounded, title: 'System', mode: ThemeMode.system, groupValue: mode, color: Colors.grey),
        ]),
        const SizedBox(height: 32),
        _SettingsGroup(title: 'About', children: [
          _SettingsRow(icon: Icons.travel_explore_rounded, title: AppConstants.appName, subtitle: 'Explore the world, one country at a time.', color: Theme.of(context).colorScheme.primary),
          _SettingsRow(icon: Icons.info_outline_rounded, title: 'App version', trailing: AppConstants.appVersion, color: Colors.teal),
        ]),
      ]),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.children});
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

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.icon, required this.title, this.subtitle, this.trailing, required this.color});
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailing;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 16),
            Text(trailing!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ]),
      );
}

class _ThemeOption extends ConsumerWidget {
  const _ThemeOption({required this.icon, required this.title, required this.mode, required this.groupValue, required this.color});
  final IconData icon;
  final String title;
  final ThemeMode mode;
  final ThemeMode groupValue;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(mode),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500))),
            if (mode == groupValue) Icon(Icons.check_rounded, color: Theme.of(context).colorScheme.primary),
          ]),
        ),
      );
}
