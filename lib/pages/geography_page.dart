import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';

class GeographyPage extends StatelessWidget {
  const GeographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GpscPageScaffold(
      title: 'Geography',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Welcome to the Geography page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
