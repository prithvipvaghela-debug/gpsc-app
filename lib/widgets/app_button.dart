import 'package:flutter/material.dart';

enum AppButtonType { primary, secondary, outline }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = AppButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onTap;
  final AppButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(label),
        ],
      ],
    );

    final style = _getButtonStyle(context);

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: type == AppButtonType.outline
          ? OutlinedButton(
              onPressed: isLoading ? null : onTap,
              style: style,
              child: content,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onTap,
              style: style,
              child: content,
            ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    
    switch (type) {
      case AppButtonType.primary:
        return theme.elevatedButtonTheme.style!;
      case AppButtonType.secondary:
        return theme.elevatedButtonTheme.style!.copyWith(
          backgroundColor: WidgetStateProperty.all(theme.colorScheme.secondary),
        );
      case AppButtonType.outline:
        return theme.outlinedButtonTheme.style!;
    }
  }
}
