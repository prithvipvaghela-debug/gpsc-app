import 'package:flutter/material.dart';

import 'app_banner_ad.dart';
import 'centered_page_body.dart';
import 'theme_toggle_button.dart';

class GpscPageScaffold extends StatelessWidget {
  const GpscPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.maxWidth = 420,
    this.showHomeAction = false,
    this.drawer,
  });

  final String title;
  final Widget child;
  final double maxWidth;
  final bool showHomeAction;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool canPop = Navigator.of(context).canPop();

    return Scaffold(
      drawer: drawer,
      bottomNavigationBar: const AppBannerAd(),
      body: SafeArea(
        child: CenteredPageBody(
          maxWidth: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, canPop),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool canPop) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Row(
        children: [
          if (canPop) ...[
            _CircularIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () => Navigator.of(context).maybePop(),
              tooltip: 'Back',
            ),
            const SizedBox(width: 16),
          ] else if (drawer != null) ...[
            Builder(
              builder: (context) => _CircularIconButton(
                icon: Icons.menu_rounded,
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'Menu',
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          const ThemeToggleButton(),
        ],
      ),
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  const _CircularIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.colorScheme.onSurface.withOpacity(0.08),
          width: 1.5,
        ),
        boxShadow: isDark ? null : [
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
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 20,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
