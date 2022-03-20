import 'dart:convert';

class GeneralUtils {
   static final _decoder = const JsonDecoder();
   static final _encoder = const JsonEncoder();

  static dynamic decode(request) async =>
      _decoder.convert(await request.readAsString());

  static dynamic encode(dynamic data) => _encoder.convert(data);
}
