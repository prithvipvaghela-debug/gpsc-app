import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
    this.borderSide,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? borderRadius;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = theme.cardTheme.shape;

    BorderSide resolvedSide;
    if (borderSide != null) {
      resolvedSide = borderSide!;
    } else if (shape is RoundedRectangleBorder) {
      resolvedSide = shape.side;
    } else {
      resolvedSide = BorderSide.none;
    }

    Widget cardContent = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        child: cardContent,
      );
    }

    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        side: resolvedSide,
      ),
      child: cardContent,
    );
  }
}
