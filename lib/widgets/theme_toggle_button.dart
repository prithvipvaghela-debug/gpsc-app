import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.light);

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  void _toggleTheme() {
    appThemeMode.value = appThemeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, themeMode, child) {
        final bool isDarkMode = themeMode == ThemeMode.dark;
        final theme = Theme.of(context);

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.onSurface.withOpacity(0.08),
              width: 1.5,
            ),
            boxShadow: isDarkMode ? null : [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggleTheme,
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
