import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../api.dart';
import '../response/department_response.dart';
import '../utils/utils.dart';

class DepartmentController {
  final res = DepartmentResponse();
  Future<Response> _get(Request request) async {
    switch (request.url.toString()) {
      case 'departments':
        return res.okResponse(await API.index());

      default:
        return res.failedResponse();
    }
  }
  Future<Response> _post(Request request) async {
    switch (request.url.toString()) {
      case 'department':
        try {
          dynamic data = await GeneralUtils.decode(request);
          return res.okResponse(await API.addItem(data));
        } catch (e) {
          return res.errorResponse();
        }
      default:
        return res.failedResponse();
    }
  }

  Future<Response> handler(Request request) async {
    switch (request.method) {
      case 'GET':
        return _get(request);

      case 'POST':
        return _post(request);

      default:
        return Response.notFound('Not Found');
    }
  }
}