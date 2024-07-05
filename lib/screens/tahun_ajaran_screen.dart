import 'package:flutter/material.dart';

class TahunAjaranScreen extends StatelessWidget {
  const TahunAjaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahun Ajaran'),
      ),
      body: ListView(
        children: <Widget>[
          // This would be replaced with actual data fetched from a database
          ListTile(
            title: const Text('2021/2022'),
            onTap: () {
              // Navigate to details or edit screen
            },
          ),
          ListTile(
            title: const Text('2022/2023'),
            onTap: () {
              // Navigate to details or edit screen
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new Tahun Ajaran screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
