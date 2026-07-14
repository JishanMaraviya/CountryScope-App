import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 88, height: 88, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, shape: BoxShape.circle), child: Icon(Icons.public_rounded, size: 48, color: Theme.of(context).colorScheme.onPrimaryContainer)).animate().scale(duration: 500.ms, curve: Curves.easeOutBack).fadeIn(),
            const SizedBox(height: 20),
            Text(AppConstants.appName, style: Theme.of(context).textTheme.headlineSmall).animate().fadeIn(delay: 250.ms).slideY(begin: .2),
            const SizedBox(height: 8),
            Text('Discover every corner of the world', style: Theme.of(context).textTheme.bodyMedium).animate().fadeIn(delay: 450.ms),
          ]),
        ),
      );
}
