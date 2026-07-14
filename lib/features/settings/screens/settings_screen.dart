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
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Card(child: Column(children: [
          _ThemeOption(icon: Icons.light_mode_rounded, title: 'Light', mode: ThemeMode.light, groupValue: mode),
          _ThemeOption(icon: Icons.dark_mode_rounded, title: 'Dark', mode: ThemeMode.dark, groupValue: mode),
          _ThemeOption(icon: Icons.brightness_auto_rounded, title: 'Use device setting', mode: ThemeMode.system, groupValue: mode),
        ])),
        const SizedBox(height: 24),
        Text('About', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Card(child: Column(children: [
          const ListTile(leading: Icon(Icons.travel_explore_rounded), title: Text(AppConstants.appName), subtitle: Text('Explore the world, one country at a time.')),
          const Divider(height: 1),
          const ListTile(leading: Icon(Icons.info_outline_rounded), title: Text('App version'), trailing: Text(AppConstants.appVersion)),
        ])),
      ]),
    );
  }
}

class _ThemeOption extends ConsumerWidget {
  const _ThemeOption({required this.icon, required this.title, required this.mode, required this.groupValue});
  final IconData icon;
  final String title;
  final ThemeMode mode;
  final ThemeMode groupValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) => RadioListTile<ThemeMode>(
        value: mode,
        groupValue: groupValue,
        onChanged: (value) {
          if (value != null) ref.read(themeModeProvider.notifier).setThemeMode(value);
        },
        secondary: Icon(icon),
        title: Text(title),
      );
}
