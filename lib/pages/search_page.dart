import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GpscPageScaffold(
      title: 'Search Topics',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.manage_search_rounded,
              size: 100,
              color: theme.colorScheme.primary.withOpacity(0.1),
            ),
            const SizedBox(height: 24),
            Text(
              'Search Coming Soon',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
