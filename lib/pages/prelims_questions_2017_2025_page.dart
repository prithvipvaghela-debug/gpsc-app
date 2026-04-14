import 'package:flutter/material.dart';

import '../widgets/app_banner_ad.dart';

class PrelimsQuestions2017To2025Page extends StatelessWidget {
  const PrelimsQuestions2017To2025Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2017 to 2025 Prelims Questions Paper'),
      ),
      bottomNavigationBar: const AppBannerAd(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '2017 to 2025 Prelims question papers will be shown here.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
