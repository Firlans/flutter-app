import 'package:mysql_client/mysql_client.dart';

class DatabaseManager {
  late MySQLConnectionPool _connection;

  DatabaseManager({
    required String host,
    required int port,
    required String userName,
    required int maxConn,
    required String password,
    required String databaseName,
  }) {
    _connection = MySQLConnectionPool(
      host: host,
      port: port,
      userName: userName,
      maxConnections: maxConn,
      password: password,
      databaseName: databaseName,
    );
  }

  Future<List<Iterable<ResultSetRow>>> executeQuery(String query) async {
    try {
      final results = await _connection.execute(query);
      return results.map((r) => r.rows).toList();
    } catch (e) {
      print('Error executing query: $e');
      rethrow;
    }
  }
  Future<void> closeConnection() async {
    try {
      await _connection.close();
      print('Database connection closed.');
    }catch(e){
      print('Error closing database connection: $e');
    }
  }
}
