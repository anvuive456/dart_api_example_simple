import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'api.dart';
import 'controllers/department_controller.dart';
import 'utils/utils.dart';


void main(List<String> args) async {
  Server.start();
}

 class Server {

  static Future<Response> _get(Request request) async {
    switch (request.url.toString()) {
      case 'items':
        return Response.ok(GeneralUtils.encode(await API.index()));

      default:
        return Response.notFound('Not Found');
    }
  }

  static Future<Response> _post(Request request) async {
    switch (request.url.toString()) {
      case 'item':
        try {
          dynamic data = await GeneralUtils.decode(request);
          return Response.ok(GeneralUtils.encode(await API.addItem(data)));
        } catch (e) {
          return Response(400);
        }
      default:
        return Response.notFound('Not Found');
    }
  }

  static Future<Response> _handle(Request request) async {
    switch (request.method) {
      case 'GET':
        return _get(request);

      case 'POST':
        return _post(request);

      default:
        return Response.notFound('Not Found');
    }
  }

  static Future<void> start() async {
    File('db.env').readAsString().then((value) => print(value));
    String filename = File('db.env').path;
    print(filename);
    dotenv.load(filename);

    await API.init(dotenv.env);

    dynamic handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(DepartmentController().handler);

    int port = int.parse(dotenv.env['PORT'] ?? '8080');
    HttpServer server = await io.serve(handler, 'localhost', port);
    print('Serving at http://${server.address.host}:${server.port}');
  }
}
