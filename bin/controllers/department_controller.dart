import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../database/db.dart';
import '../models/department_model.dart';
import '../response/response.dart';
import '../utils/utils.dart';

class DepartmentController {
  final res = ApiResponse();

  Future<Response> getALlDepartments(Request request) async {
    List<Map<String, dynamic>> items = [];
    dynamic result = await DB().query('select * from department');
    print('result of db query: ${result}');
    for (final row in result) {
      items.add(row['department']);
    }
    switch (request.url.toString()) {
      case 'departments':
        return res.okResponse(items);
      default:
        return res.failedResponse();
    }
  }

  Future<Response> getSingleDepartment(
      Request request, String department_id) async {
    Map<String, dynamic> item = {};

    try {
      String sql = "select * from department where department_id = @id";
      dynamic result = await DB().query(sql, values: {'id': department_id});
      if (result is List && result.isNotEmpty) {
        item = result[0]['department'];
        return res.okResponse(item);
      } else
        return res.okResponse(null);
    } catch (e) {
      print(e);
      return res.errorResponse();
    }
  }

  Future<Response> updateDepartment(Request request) async {
    try {
      dynamic data = await GeneralUtils.decode(request);
      final item = DepartmentModel.map(data);
      String sql =
          "update department set department_name = @name where department_id = @id returning *";
      print('sql: $sql');
      Map<String, dynamic> params = {'id': item.id, 'name': item.name};

      dynamic result = await DB().query(sql, values: params);
      if (result is List && result.isNotEmpty) {
        return res.okResponse(result[0]['department']);
      } else {
        return res.okResponse(null);
      }
    } catch (e) {
      return res.errorResponse();
    }
  }

  Future<Response> deleteDepartment(Request request, String id) async {
    try {
      String sql =
          "delete from department where department_id =@id returning *";
      dynamic result = await DB().query(sql, values: {'id': id});
      if (result is List && result.isNotEmpty) {
        return res.okResponse(result[0]['department']);
      } else {
        return res.successResponse();
      }
    } catch (e) {
      return res.errorResponse();
    }
  }

  Future<Response> addDepartment(Request request) async {
    try {
      dynamic data = await GeneralUtils.decode(request);
      final item = DepartmentModel.map(data);
      String sql =
          "insert into department (department_id,department_name) values (@id, @name ) returning *";
      print('sql: $sql');
      Map<String, dynamic> params = {'id': item.id, 'name': item.name};

      dynamic result = await DB().query(sql, values: params);
      if (result is List && result.isNotEmpty) {
        return res.okResponse(result[0]['department']);
      } else {
        return res.okResponse(null);
      }
    } catch (e) {
      return res.errorResponse();
    }
  }
}
