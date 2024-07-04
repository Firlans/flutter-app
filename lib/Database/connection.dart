import 'DatabaseManager.dart';

void main() async {
  final dbManager = DatabaseManager(
    host: 'localhost',
    port: 3306,
    userName: 'root',
    maxConn: 10,
    password: 'Firlansyah100%',
    databaseName: 'flutter_app',
  );

  try {
    final query = "SELECT nama_lengkap, nim FROM mahasiswa";
    final results = await dbManager.executeQuery(query);

    for (final row in results) {
      // Ensure row is not empty before accessing its elements
      if (row.isNotEmpty) {
        // Print the values
        print(row.elementAt(0).assoc());
      } else {
        print('Error: Row is empty or does not contain expected data.');
      }
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    await dbManager.closeConnection();
  }
}
