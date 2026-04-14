import 'package:flutter/material.dart';

import 'theme_toggle_button.dart';

PreferredSizeWidget buildGpscAppBar(String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    actions: const [
      ThemeToggleButton(),
    ],
  );
}
