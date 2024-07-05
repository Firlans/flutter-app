import 'package:flutter/material.dart';

class TagihanSPPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: 10, // Replace with actual data count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.receipt, color: Colors.white),
              ),
              title: Text('Tagihan SPP $index', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Details about Tagihan SPP $index'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to details screen
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new Tagihan SPP screen
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
