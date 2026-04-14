import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';

class StateNewsPage extends StatelessWidget {
  const StateNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GpscPageScaffold(
      title: 'State News',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Welcome to the State News page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
