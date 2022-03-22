import 'package:shelf/shelf.dart';

import '../database/db.dart';
import '../models/employee_model.dart';
import '../response/response.dart';
import '../utils/utils.dart';

class EmployeeController {
  static final res = ApiResponse();

  Future<Response> getALlEmployees(Request request) async {
    List<Map<String, dynamic>> items = [];
    dynamic result = await DB().query('select * from employee');
    print('result of db query: ${result}');
    for (final row in result) {
      items.add(row['employee']);
    }

    return res.okResponse(items);
  }

  Future<Response> getSingleEmployee(
      Request request, String department_id) async {
    Map<String, dynamic> item = {};

    try {
      String sql = "select * from employee where employee_id = @id";
      dynamic result = await DB().query(sql, values: {'id': department_id});
      if (result is List && result.isNotEmpty) {
        item = result[0]['employee'];
        return res.okResponse(item);
      } else
        return res.okResponse(null);
    } catch (e) {
      print(e);
      return res.errorResponse();
    }
  }

  Future<Response> updateEmployee(Request request) async {
    try {
      dynamic data = await GeneralUtils.decode(request);
      final item = EmployeeModel.map(data);
      String sql =
          "update employee set employee_name = @name where employee_id = @id returning *";
      print('sql: $sql');
      Map<String, dynamic> params = {'id': item.id, 'name': item.name};

      dynamic result = await DB().query(sql, values: params);
      if (result is List && result.isNotEmpty) {
        return res.okResponse(result[0]['employee']);
      } else {
        return res.okResponse(null);
      }
    } catch (e) {
      return res.errorResponse();
    }
  }

  Future<Response> deleteEmployee(Request request, String id) async {
    try {
      String sql =
          "delete from employee where employee_id =@id returning *";
      dynamic result = await DB().query(sql, values: {'id': id});
      if (result is List && result.isNotEmpty) {
        return res.okResponse(result[0]['employee']);
      } else {
        return res.successResponse();
      }
    } catch (e) {
      return res.errorResponse();
    }
  }

  Future<Response> addEmployee(Request request) async {
    try {
      dynamic data = await GeneralUtils.decode(request);
      final item = EmployeeModel.map(data);
      String sql =
          "insert into employee (employee_id,employee_name) values (@id, @name ) returning *";
      print('sql: $sql');
      Map<String, dynamic> params = {'id': item.id, 'name': item.name};

      dynamic result = await DB().query(sql, values: params);
      if (result is List && result.isNotEmpty) {
        return res.okResponse(result[0]['employee']);
      } else {
        return res.okResponse(null);
      }
    } catch (e) {
      return res.errorResponse();
    }
  }
}
