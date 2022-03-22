import 'package:postgres/postgres.dart';

class DB {
  static final DB _singleton = DB._internal();

  factory DB() {
    return _singleton;
  }

  DB._internal();

  late PostgreSQLConnection _connection;

  static Future<DB> connect(Map<String, dynamic> env) async {

    int _port = int.parse(env['DB_PORT']);
    String _host = env['DB_HOST'];
    String _user = env['DB_USER'];
    String _pass = env['DB_PASS'];
    String _name = env['DB_NAME'];

    DB db = DB();
    db._connection = PostgreSQLConnection(_host, _port, _name, username: _user, password: _pass);
    await db._connection.open();
    return db;
  }

  Future<List<dynamic>> query(String sql, {  Map<String, dynamic>? values }) async {

    try {
      return await _connection.mappedResultsQuery(sql, substitutionValues: values);
    }
    catch(e) {
      print(e);
      return Future.value([]);
    }
  }

}