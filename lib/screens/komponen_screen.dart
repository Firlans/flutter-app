import 'package:flutter/material.dart';

class KomponenScreen extends StatelessWidget {
  const KomponenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 10, // Replace with actual data count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: const CircleAvatar(
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.widgets, color: Colors.white),
              ),
              title: Text('Komponen $index', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Details about Komponen $index'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to details screen
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new Komponen screen
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
