import 'package:shelf/shelf.dart';

import '../utils/utils.dart';

class DepartmentResponse {
  _resBody(dynamic data) =>
      GeneralUtils.encode({'data': data});

  Response okResponse(dynamic data) {
    return Response.ok(_resBody(data));
  }

  Response failedResponse() {
    return Response.notFound('Not Found Department');
  }

  Response errorResponse(){
    return Response(400);
  }
}
