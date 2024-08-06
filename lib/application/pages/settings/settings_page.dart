import 'package:flutter/material.dart';
import 'package:todo_clean_appp/application/core/page_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static final pageConfig = PageConfig(
    icon: Icons.settings_accessibility_rounded,
    name: 'settings',
    child: const SettingsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SettingsPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
