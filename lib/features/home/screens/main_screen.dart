import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Determine the selected index based on the current location.
    final String location = GoRouterState.of(context).uri.path;
    final int selectedIndex = _calculateSelectedIndex(location);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBody: true,
        body: Stack(
        children: [
          child,
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: _FloatingBottomBar(
              selectedIndex: selectedIndex,
              onHomeTap: () => context.go('/home'),
              onFavoritesTap: () => context.go('/favorites'),
              onSettingsTap: () => context.go('/settings'),
            ),
          ),
        ],
      ),
    ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/favorites')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0; // Default to home
  }
}

class _FloatingBottomBar extends StatelessWidget {
  const _FloatingBottomBar({
    required this.selectedIndex,
    required this.onHomeTap,
    required this.onFavoritesTap,
    required this.onSettingsTap,
  });

  final int selectedIndex;
  final VoidCallback onHomeTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3), width: 1),
              boxShadow: [
                BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 32, offset: const Offset(0, 16)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavBarItem(icon: Icons.explore_rounded, label: 'Explore', isSelected: selectedIndex == 0, onTap: onHomeTap),
                const SizedBox(width: 24),
                _NavBarItem(icon: Icons.favorite_outline_rounded, label: 'Favorites', isSelected: selectedIndex == 1, onTap: onFavoritesTap),
                const SizedBox(width: 24),
                _NavBarItem(icon: Icons.tune_rounded, label: 'Settings', isSelected: selectedIndex == 2, onTap: onSettingsTap),
              ],
            ),
          ).animate().slideY(begin: 1, duration: 800.ms, curve: Curves.easeOutBack).fadeIn(duration: 800.ms),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({required this.icon, required this.label, required this.isSelected, required this.onTap});
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant, size: 24),
          ),
        ],
      ),
    );
  }
}
