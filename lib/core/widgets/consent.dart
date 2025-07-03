import 'package:flutter/material.dart';

class ConsentPage extends StatelessWidget {
  const ConsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
            "By using this app, you consent to the storage of your bookmarks and related data locally on your device using a secure SQLite database. This data will not be shared or uploaded to external servers unless explicitly indicated by you (e.g., for backup purposes)\nData Retention:\nPlease note that all stored data, including bookmarks, is saved locally on your device. If you change or reset your device, or uninstall this app, your data may be permanently lost. We recommend periodically backing up your data to prevent loss.\nIf you do not wish to store data locally, please refrain from using the bookmarking feature.\nBy continuing, you acknowledge and accept these terms regarding local data storage.",
          )
        ],
      ),
    );
  }
}
