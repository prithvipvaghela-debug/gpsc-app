import 'package:flutter/material.dart';

class CenteredPageBody extends StatelessWidget {
  const CenteredPageBody({
    super.key,
    required this.child,
    this.maxWidth = 400,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
