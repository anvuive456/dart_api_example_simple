import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'controllers/route_config.dart';
import 'controllers/department_controller.dart';
import 'database/db.dart';
import 'utils/utils.dart';


void main(List<String> args) async {
  Server.start();
}

 class Server {


  static Future<void> start() async {
    File('db.env').readAsString().then((value) => print(value));
    String filename = File('db.env').path;
    print(filename);
    dotenv.load(filename);

    await DB.connect(dotenv.env);

    dynamic handler =
    const Pipeline().addMiddleware(logRequests()).addHandler(RouteConfig.route);

    int port = int.parse(dotenv.env['PORT'] ?? '8080');
    HttpServer server = await io.serve(handler, 'localhost', port);
    print('Serving at http://${server.address.host}:${server.port}');
  }
}
