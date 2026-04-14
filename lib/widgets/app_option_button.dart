import 'package:flutter/material.dart';

class AppOptionButton extends StatelessWidget {
  const AppOptionButton({
    super.key,
    required this.option,
    required this.index,
    required this.onTap,
    this.isSelected = false,
    this.isCorrect = false,
    this.isWrong = false,
    this.showResult = false,
  });

  final String option;
  final int index;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool showResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    if (!showResult) {
      backgroundColor = isSelected 
          ? theme.colorScheme.primary 
          : theme.colorScheme.surface;
      foregroundColor = isSelected 
          ? theme.colorScheme.onPrimary 
          : theme.colorScheme.onSurface;
      borderSide = BorderSide(
        color: isSelected 
            ? theme.colorScheme.primary 
            : theme.colorScheme.outline.withOpacity(0.5),
        width: 1.5,
      );
    } else {
      if (isCorrect) {
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
      } else if (isWrong) {
        backgroundColor = Colors.red;
        foregroundColor = Colors.white;
      } else {
        backgroundColor = theme.colorScheme.surface;
        foregroundColor = theme.colorScheme.onSurface.withOpacity(0.5);
        borderSide = BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.3),
          width: 1,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: showResult ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: borderSide != BorderSide.none ? Border.fromBorderSide(borderSide) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: foregroundColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: foregroundColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    option,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: foregroundColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
                if (showResult && isCorrect)
                  const Icon(Icons.check_circle_rounded, color: Colors.white, size: 24),
                if (showResult && isWrong)
                  const Icon(Icons.cancel_rounded, color: Colors.white, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
