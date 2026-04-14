import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';

class PolityPage extends StatelessWidget {
  const PolityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GpscPageScaffold(
      title: 'Indian Polity',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Welcome to the Indian Polity page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
