import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';

class ImportantDatesPage extends StatelessWidget {
  const ImportantDatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GpscPageScaffold(
      title: 'Important Dates and Events',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Welcome to the Important Dates and Events page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
