import 'dart:async';

import 'db.dart';
import 'models/department_model.dart';


abstract class API {

  static DB _db = DB();

  static init(Map<String, dynamic> env) async =>
      _db = await DB.connect(env);

  static Future<List<dynamic>> index() async {

    List<Map<String, dynamic>> items = [];
    dynamic result = await _db.query('select * from department');
     print('result of db query: ${result}');
    for (final row in result) { items.add(row['department']); }
    return items;
  }

  static Future<Map<String, dynamic>> addItem(dynamic data) async {

    final item = DepartmentModel.map(data);
    String sql = "insert into department (department_id,department_name) values (@id, @name ) returning department_id";
    print('sql: $sql');
    Map<String, dynamic> params = { 'id': item.id, 'name': item.name};

    dynamic result = await _db.query(sql, values: params);

    return { "id": result[0]['department']['department_id'] };
  }
}