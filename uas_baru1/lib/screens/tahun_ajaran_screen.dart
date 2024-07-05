import 'package:flutter/material.dart';

class TahunAjaranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tahun Ajaran'),
      ),
      body: ListView(
        children: <Widget>[
          // This would be replaced with actual data fetched from a database
          ListTile(
            title: Text('2021/2022'),
            onTap: () {
              // Navigate to details or edit screen
            },
          ),
          ListTile(
            title: Text('2022/2023'),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
