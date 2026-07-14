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
    Future<void>.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1), blurRadius: 40, spreadRadius: 5, offset: const Offset(0, 10)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack).fadeIn(duration: 600.ms),
            const SizedBox(height: 32),
            Text(AppConstants.appName, style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: -0.5))
                .animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: .1, curve: Curves.easeOutQuad),
            const SizedBox(height: 12),
            Text('Discover every corner of the world', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))
                .animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: .1, curve: Curves.easeOutQuad),
          ]),
        ),
      );
}
