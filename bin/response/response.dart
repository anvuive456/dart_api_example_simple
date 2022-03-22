
import 'package:shelf/shelf.dart';

import '../utils/utils.dart';

class ApiResponse {
  _resBody(dynamic data) =>
      GeneralUtils.encode({'data': data});

  Response okResponse(dynamic data) {
    return Response.ok(_resBody(data),headers: GeneralUtils.header);
  }

  Response successResponse() {
    return Response(200,headers: GeneralUtils.header,);
  }

  Response failedResponse() {
    return Response.notFound('Not Found Department',headers: GeneralUtils.header);
  }

  Response errorResponse(){
    return Response(400,headers: GeneralUtils.header);
  }
}